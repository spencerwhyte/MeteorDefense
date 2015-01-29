//
//  MovieFinishedDelegate.h
//  TD
//
//  Created by Spencer Whyte on 11-04-07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MovieFinishedDelegate
@optional
- (void)movieDidFinish:(NSNotification*)aNotification;

@end
