//
//  PlayVideoViewController.h
//  TD
//
//  Created by Mark corbelli on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PlaySoundController.h"

@interface PlaySoundController : NSObject {
	
}
+(void)playSoundAtURL:(NSURL*)url inView:(UIView*)view withDelegate:(NSObject*)delegate;
-(void)mySoundFinishedCallback:(NSNotification*)aNotification;
@end
