//
//  PlayVideoViewController.m
//  TD
//
//  Created by Mark corbelli on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "PlaySoundController.h"
//#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
//#import "MovieFinishedDelegate.h"
@implementation PlaySoundController

+(void)playSoundAtURL:(NSURL*)url

{
	NSString *soundFilePath =
	[[NSBundle mainBundle] pathForResource: @"sound"
									ofType: @"wav"];
	
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *newPlayer =
	[[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
										   error: nil];
	[fileURL release];
	
	self.player = newPlayer;
	[newPlayer release];
	
	[player prepareToPlay];
	[player setDelegate: self];
	[super viewDidLoad];
	
} 

// When the movie is done,release the controller. 


@end