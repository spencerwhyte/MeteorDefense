//
//  PlayVideoViewController.m
//  TD
//
//  Created by Mark corbelli on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "PlayVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MovieFinishedDelegate.h"
@implementation PlayVideoViewController

+(void)playMovieAtURL:(NSURL*)url inView:(UIView*)view withDelegate:(NSObject*)delegate

{

     MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [moviePlayerController.view setBounds:view.bounds];
    [moviePlayerController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [moviePlayerController.moviePlayer prepareToPlay];
    [view addSubview:moviePlayerController.moviePlayer.view];
    [moviePlayerController.moviePlayer play];
    [moviePlayerController.moviePlayer setFullscreen:YES];
  //  [moviePlayerController.moviePlayer setControlStyle:MPMovieControlStyleNone];
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(myMovieFinishedCallback:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:moviePlayerController.moviePlayer]; 
    if(delegate !=nil){
    [[NSNotificationCenter defaultCenter] addObserver:delegate 
											 selector:@selector(movieDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:moviePlayerController.moviePlayer]; 
    }
//	[moviePlayerController release];
   
} 

// When the movie is done,release the controller. 
+(void)myMovieFinishedCallback:(NSNotification*)aNotification 
{
    MPMoviePlayerController* theMovie=[aNotification object]; 
    
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:MPMoviePlayerPlaybackDidFinishNotification 
                                                  object:theMovie]; 
    [theMovie.view removeFromSuperview];
   // [theMovie];
    // Release the movie instance created in playMovieAtURL
    [theMovie release]; 
}

@end