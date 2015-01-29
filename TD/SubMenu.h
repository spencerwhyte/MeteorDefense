//
//  SBMenu.h
//  TD
//
//  Created by Spencer Whyte on 11-02-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameObject.h"
#import "GameWorld.h"
#import "TDViewController.h"
static GLuint menuBackground;


static GLuint upgradeButton;
static GLuint recycleButton;

static GLuint exitButton;

@class SBMenu;
static SBMenu * currentMenu;

static float tempx;
static float tempy;

@interface SubMenu : GameObject {
@private
    int selected;
    int menuState;
    double creationTime;
	
}


-(int)checkX:(float)x1 checkY:(float)y1;
+(void)touchX:(float)x touchY:(float)y;
+(void)load;
+(void)draw;
+(SubMenu*)currentMenu;
+(bool)manualControlSelect;
+(void)setManualControlSelect:(bool)selected;
+(void)reset;
@property int selected;
@property int menuState;
@property double creationTime;
@end





