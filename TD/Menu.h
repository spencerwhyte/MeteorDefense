//
//  Menu.h
//  TD
//
//  Created by Spencer Whyte on 11-03-01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loader.h"
#import "GameWorld.h"
#import "Audio.h"
//#import "PlaySoundController.h"

static GLuint menuBackground;
static GLuint scoreButton;
static GLuint startButton;

static GLuint tutorialButton;
static GLuint creditsButton;

static GLuint scoreButton2;
static GLuint startButton2;

static int selectedMenuItem;

static bool normal3;
static bool tutorial3;

@interface Menu : NSObject {
@private
    
}


+(void)draw;
+(void)load;
+ (void)touchesBeganX:(float)x andY:(float)y;

+ (void)touchesMovedX:(float)x andY:(float)y;

+ (int)touchesEndedX:(float)x andY:(float)y;
+ (void)touchesCancelledX:(float)x andY:(float)y;


@end
