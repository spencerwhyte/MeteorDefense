//
//  PlayVideoViewController.h
//  TD
//
//  Created by Mark corbelli on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayVideoViewController : NSObject {

}
+(void)playMovieAtURL:(NSURL*)url inView:(UIView*)view withDelegate:(NSObject*)delegate;
-(void)myMovieFinishedCallback:(NSNotification*)aNotification;
@end
