//
//  TDViewController.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "GameWorld.h"
#import "ParticleSystem.h"
#import "Menu.h"
#import "ScoreBoard.h"
#import "Sounds.h"
//#import "SubMenu.h"
#import "Score.h"
#import "Credit.h"
#import "Tutorial.h"
#import "PlayVideoViewController.h"
#import "MovieFinishedDelegate.h"
#import "Audio.h"
@class GameWorld;
@class ScoreBoard;
 bool subMenuMode;
 bool SBsubMenuMode;
bool tut;
@interface TDViewController : UIViewController<MovieFinishedDelegate> {
@private
    EAGLContext *context;
    GLuint program;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
    GameWorld *currentGameWorld;
    int gameState;
    
    UITextField *nameTextField;
        IBOutlet ScoreBoard * sb;
   
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;
- (void)movieDidFinish:(NSNotification*)aNotification;
- (void)startAnimation;
- (void)stopAnimation;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
