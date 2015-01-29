//
//  GameWorld.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "GameObject.h"
#import "Satellite.h"
#import "Asteroid.h"
#import "finalComet.h"
#import "SpaceBase.h"
#import "Audio.h"
#import "Sounds.h"
static int test;
#import "PlayVideoViewController.h"
#import "SBMenu.h"
#import "SubMenu.h"
#import "SatelliteVariant.h"
#import "SatelliteBulletVariant.h"
#import "Score.h"
#import "ElectricFence.h"
#import "FusionCoil.h"
#import "StaryBackground.h"
NSMutableArray *objects;

float width;
float height;
GameObject * moveObject;
    bool firstUpdate2; // Whether or not this is the first frame update
static GLuint texture;
static GLuint texture2;
static GLuint texture3;


@interface GameWorld : NSObject {
@private
    
    double lastTime; // The last time of the frame update
   bool firstUpdate; // Whether or not this is the first frame update
    double levelStart; 
	bool meteorsEnded;
	double meteorsEnded1;
}
- (id)initWithWidth:(float)tempWidth andHeight:(float)tempHeight;
-(void)draw;
-(void)update;
- (void)touchesBeganX:(float)x andY:(float)y;
- (void)touchesMovedX:(float)x andY:(float)y;
- (void)touchesEndedX:(float)x andY:(float)y;
- (void)touchesCancelledX:(float)x andY:(float)y;
+(void)audio;
-(BOOL)withinX:(float)x withinY:(float)y;

-(void)pause;
-(void)reset;


@end
