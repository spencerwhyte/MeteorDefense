//
//  Tutorial.m
//  TD
//
//  Created by Mark corbelli on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "Tutorial.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation Tutorial

- (void)viewDidLoad{
    
	 NSString *url = [[NSBundle mainBundle] 
					 pathForResource:@"tutorial" 
					 ofType:@"m4v"];
	
    MPMoviePlayerController *player = 
	[[MPMoviePlayerController alloc] 
	 initWithContentURL:[NSURL fileURLWithPath:url]];
    
    [[NSNotificationCenter defaultCenter] 
	 addObserver:self
	 selector:@selector(movieFinishedCallback:)                                                 
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:player];
    
    //---play movie---
    [player play];    
    [super viewDidLoad];    
}

- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter] 
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:player];    
    [player autorelease];    
//return 0;
}


@end