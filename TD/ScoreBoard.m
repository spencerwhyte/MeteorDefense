//
//  ScoreBoard.m
//  TD
//
//  Created by Spencer Whyte on 11-03-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreBoard.h"


@implementation ScoreBoard

- (id)init {
    if ((self = [super init])) {
        
        
        
        
        
    }
    
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //cell.backgroundColor = [UIColor blackColor];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == local){
        return [scores count];
    }else if(tableView == monthly){
        return [monthScores count];
    }else if(tableView == allTime){
        return [allTimeScores  count];
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell.
    
    
    
    if(tableView == local){
        [cell.textLabel setText:  [[NSString alloc] initWithFormat:@"%d. %@",[indexPath indexAtPosition:1] + 1,[scoreNames objectAtIndex:[indexPath indexAtPosition:1]]]];
        cell.detailTextLabel.text = [scores objectAtIndex:[indexPath indexAtPosition:1]] ; 
    }else if(tableView == monthly){
        [cell.textLabel setText:  [[NSString alloc] initWithFormat:@"%d. %@",[indexPath indexAtPosition:1] + 1,[monthScoreNames objectAtIndex:[indexPath indexAtPosition:1]]]];
        cell.detailTextLabel.text = [monthScores objectAtIndex:[indexPath indexAtPosition:1]] ; 
    }else if(tableView == allTime){
        [cell.textLabel setText:  [[NSString alloc] initWithFormat:@"%d. %@",[indexPath indexAtPosition:1] + 1,[allTimeScoreNames objectAtIndex:[indexPath indexAtPosition:1]]]];
        cell.detailTextLabel.text = [allTimeScores objectAtIndex:[indexPath indexAtPosition:1]] ; 
    }
        
        
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+(void)registerScore:(int)score forName:(NSString * )name{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(scores == nil){
        
        scores = [[NSMutableArray alloc] init];
        scoreNames = [[NSMutableArray alloc] init];
        
        if([defaults integerForKey: @"scoreCount"] == 0){
            [defaults setInteger:1 forKey:@"scoreCount"];
        }else{
            int scoreCount= [defaults integerForKey:@"scoreCount"];
            scoreCount--;
            for(int i = 0 ; i < scoreCount ; i++){
                [scoreNames addObject: [defaults stringForKey: [[NSString alloc] initWithFormat:@"name%d", i]]];
                [scores addObject: [defaults stringForKey: [[NSString alloc] initWithFormat:@"score%d", i]]];
    
            }
            [ScoreBoard sortScores];
        }
        
    }
    
    if([name length] > 0){
        int scoreCount= [defaults integerForKey:@"scoreCount"];
        
        scoreCount--;        
        
        [defaults setInteger:score forKey:[[NSString alloc] initWithFormat:@"score%d",scoreCount]];
        
        [defaults setObject:name forKey:[[NSString alloc] initWithFormat:@"name%d",scoreCount]];
        
        [scores addObject:[[NSString alloc] initWithFormat:@"%d", score]];
        
        [scoreNames addObject:name];
        
        [defaults setInteger:scoreCount+2 forKey:@"scoreCount"];
        [scoreBoard registerShow:score forName:name];
        
        
        
        
        NSURL *url = [NSURL URLWithString:@"http://www.inysis.com/a.php"];
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url 
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                                       timeoutInterval:60];
        
        [req setHTTPMethod:@"POST"];		
        [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        NSString *postData = [NSString stringWithFormat:@"scoreName=%@&score=%d", name, score];
        NSLog(@"%@", postData);
        
        NSString *length = [NSString stringWithFormat:@"%d", [postData length]];	
        [req setValue:length forHTTPHeaderField:@"Content-Length"];	
        
        [req setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
        networkData =[[NSMutableData alloc] init];
        NSURLConnection *connectionResponse = [[NSURLConnection alloc] initWithRequest:req delegate:scoreBoard];

    }
    
    
    [defaults synchronize];
    
    [scoreBoard registerShow:score forName:name];
    
    [ScoreBoard sortScores];
    [scoreBoard.localite reloadData];
    
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [networkData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSString *responseString = [[NSString alloc] initWithData:networkData encoding:NSASCIIStringEncoding];
    NSString * responseString2 =    [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray * stuff = [responseString2 componentsSeparatedByString:@"\n"];
    allTimeScores = [[NSMutableArray alloc] init];
    monthScores = [[NSMutableArray alloc] init];

    
    allTimeScoreNames = [[NSMutableArray alloc] init];
    monthScoreNames = [[NSMutableArray alloc] init];
    NSLog(@"%@", responseString2);
    
    int index = 0;
    
    while([[stuff objectAtIndex:index] length] !=0){
        [allTimeScoreNames addObject:[stuff objectAtIndex:index]];
        index++;
        [allTimeScores addObject:[stuff objectAtIndex:index]];
        index++;
    }
    
    index++;
    
    while(index < [stuff count]){
        [monthScoreNames addObject:[stuff objectAtIndex:index]];
        index++;
        [monthScores addObject:[stuff objectAtIndex:index]];
        index++;
    }
    
    
    [monthlyActivityIndicator stopAnimating];
    [allTimeActivityIndicator stopAnimating];
    
    [monthly reloadData];
    [allTime reloadData];
    [networkData release];
    networkData = nil;
   
    [responseString release];
}

+(void)sortScores{
    
    if([scores count ] > 1){
        
        NSMutableArray *scores2 = [[NSMutableArray alloc] init];  
        
        NSMutableArray *scoreNames2 = [[NSMutableArray alloc] init];

        while([scores count] > 0){
            int highest = -100000;
            int highestIndex= -10;
            for(int i = 0 ; i< [scores count] ; i++){
                if(  [[scores objectAtIndex:i] integerValue]   > highest){  
                    highest =  [[scores objectAtIndex:i] integerValue];
                    highestIndex = i;
                }
            }
            [scores2 addObject:[scores objectAtIndex:highestIndex]];
            [scoreNames2 addObject:[scoreNames objectAtIndex:highestIndex]];
            [scores removeObjectAtIndex:highestIndex];
            [scoreNames removeObjectAtIndex:highestIndex];
        }
        [scores release];
        [scoreNames release];
        
        scores = scores2;
        scoreNames = scoreNames2;
        
    }
}

+(void)showScoreBoard:(UIView * )view{
    
        scores = [[NSMutableArray alloc] init];

        scoreNames = [[NSMutableArray alloc] init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults integerForKey: @"scoreCount"] == 0){
            NSLog(@"Created");
            [defaults setInteger:1 forKey:@"scoreCount"];
        }else{
            int scoreCount= [defaults integerForKey:@"scoreCount"];
            scoreCount--;
            NSLog(@"%d", scoreCount);
            for(int i = 0 ; i < scoreCount ; i++){
                [scoreNames addObject: [defaults stringForKey: [[NSString alloc] initWithFormat:@"name%d", i]]];
                [scores addObject: [defaults stringForKey: [[NSString alloc] initWithFormat:@"score%d", i]]];
                
            }
            [ScoreBoard sortScores];
        }
        [defaults synchronize];
    
    
    
    
    if(networkData ==nil){
    NSURL *url = [NSURL URLWithString:@"http://www.inysis.com/a.php"];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url 
                                                       cachePolicy:NSURLRequestReloadIgnoringCacheData 
                                                   timeoutInterval:60];
    
    [req setHTTPMethod:@"POST"];		
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString *postData = @"getTopScores=blah";

    
    NSString *length = [NSString stringWithFormat:@"%d", [postData length]];	
    [req setValue:length forHTTPHeaderField:@"Content-Length"];	
    
    [req setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
    networkData =[[NSMutableData alloc] init];
    NSURLConnection *connectionResponse = [[NSURLConnection alloc] initWithRequest:req delegate:scoreBoard];
    }
    
    
    NSLog(@"Here");

    
    doneScoreBoard = false;

    [scoreBoard scoreBoardShow];
        [scoreBoard.localite reloadData];
    [view addSubview:scoreBoard.view];
}


-(void)registerShow:(int)score forName:(NSString * )name{
    [monthlyActivityIndicator startAnimating];
    [allTimeActivityIndicator startAnimating];
    [monthly setUserInteractionEnabled:NO];
    [allTime setUserInteractionEnabled:NO];
    
    [bScrollView setContentOffset:CGPointMake(320, 0)];
    
}


-(void)scoreBoardShow{

    [monthlyActivityIndicator startAnimating];
    [allTimeActivityIndicator startAnimating];
    
    [monthly setUserInteractionEnabled:NO];
    [allTime setUserInteractionEnabled:NO];
    
    [bScrollView setContentOffset:CGPointMake(320, 0)];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ( fabs(scrollView.contentOffset.y) > 0 && scrollView == bScrollView) {
        [scrollView setContentOffset:CGPointMake([scrollView contentOffset].x, 0)];
    } 
    pageControl.currentPage = ( (int)((160+[scrollView contentOffset].x)/320.0));

   NSLog(@"%d",( (int)((160+[scrollView contentOffset].x)/320.0)));
}

-(IBAction)pageControlChange:(id)sender{
    
    [bScrollView scrollRectToVisible:CGRectMake(320 * [pageControl currentPage], 0, 320, 480) animated:YES];
    
    
}

-(void)viewDidLoad{
    
    [bScrollView setScrollEnabled:YES];
    
    [bScrollView setContentSize:CGSizeMake(1280, 480)];
    [bScrollView setContentOffset:CGPointMake(320, 0)];
    
    local.layer.cornerRadius = 10;

    allTime.layer.cornerRadius = 10;

    monthly.layer.cornerRadius = 10;


}

-(IBAction)doneButtonHandler:(id)sender{
    
    doneScoreBoard = true;
    
}

+(void)setInstance:(ScoreBoard * )sb{
    scoreBoard = sb;
}

+(void)hideScoreBoard:(UIView *) view{
    [scoreBoard.view removeFromSuperview];
    [doneButton removeFromSuperview];
    doneScoreBoard = false;
}

+(bool)doneScoreBoard{
    
    return doneScoreBoard;
}


- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@synthesize localite;

@end
