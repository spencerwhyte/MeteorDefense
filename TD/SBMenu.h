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
#import "Audio.h"
#import "Sounds.h"
#import "TDViewController.h"
static GLuint menuBackground;


static GLuint constructButtonSelected;
static GLuint constructButton;

static GLuint satelliteButton;
static GLuint satelliteButtonSelected;


static GLuint fusionCoilButton;
static GLuint fusionCoilButtonSelected;

static GLuint electricFenceButton;
static GLuint electricFenceButtonSelected;

static GLuint rocketButton;
static GLuint rocketButtonSelected;

static GLuint closeButton;

static GLuint manualControlButton;
static GLuint manualControlButtonSelected;

static GLuint placeButton;
static GLuint holdButton;
static GLuint clickButton;
bool testTime;
double delay;


static GLuint quitButton;

static bool manualControlSelect;
static bool men1;
@class SBMenu;
static SBMenu * currentMenu;


static bool Tutorial1;
static bool step1;
static bool step2;
static bool step3;
static bool hidemenu1;

@interface SBMenu : GameObject {
@private
    int selected;
    int menuState;
    double creationTime;
	//int fccount;
	
}

-(int)checkX:(float)x1 checkY:(float)y1;
+(void)touchX:(float)x touchY:(float)y;
+(void)load;
+(void)draw;
+(void)setTutorial;
+(SBMenu*)currentMenu;
+(bool)manualControlSelect;
+(void)setManualControlSelect:(bool)selected;
+(void)reset;
+(void)setMenuFalse;
+(void)setMenuTrue;
+(void)Audios;
+(void)resetmenu;
+(void)hidemenu;
@property int selected;
@property int menuState;
@property double creationTime;
@end





