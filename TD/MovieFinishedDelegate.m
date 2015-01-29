//
//  MovieFinishedDelegate.m
//  TD
//
//  Created by Spencer Whyte on 11-04-07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieFinishedDelegate.h"


@protocol MovieFinishedDelegate
@optional
- (void)movieDidFinish:(NSNotification*)aNotification;

@end
