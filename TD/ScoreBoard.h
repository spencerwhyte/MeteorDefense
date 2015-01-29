//
//  ScoreBoard.h
//  TD
//
//  Created by Spencer Whyte on 11-03-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameWorld.h"
#import <QuartzCore/QuartzCore.h>

static NSMutableArray * scoreNames;
static NSMutableArray * scores;
static NSMutableArray * monthScores;
static NSMutableArray * monthScoreNames;
static NSMutableArray * allTimeScores;
static NSMutableArray * allTimeScoreNames;


@class ScoreBoard;
static ScoreBoard* scoreBoard;
static UIButton* doneButton;

static bool doneScoreBoard;
static  NSMutableData * networkData;

@interface ScoreBoard : UITableViewController <UIScrollViewDelegate> {
@private
    IBOutlet UIScrollView * bScrollView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UITableView * local;
    IBOutlet UITableView * monthly;
    IBOutlet UITableView * allTime;
    
    IBOutlet UIActivityIndicatorView * monthlyActivityIndicator;
    
    IBOutlet UIActivityIndicatorView * allTimeActivityIndicator;
    

    
}

+ (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

+(void)showScoreBoard:(UIView *) view;

+(void)hideScoreBoard:(UIView *) view;

+(bool)doneScoreBoard;

+(void)registerScore:(int)score forName:(NSString * )name;
-(IBAction)doneButtonHandler:(id)sender;
+(void)sortScores;
-(void)scoreBoardShow;
-(void)registerShow:(int)score forName:(NSString * )name;
+(void)setInstance:(ScoreBoard * )sb;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
-(IBAction)pageControlChange:(id)sender;


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
@property UITableView *localite;
@end
