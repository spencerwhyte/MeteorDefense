//
//  Satellite.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "SatelliteBullet.h"
#import "GameWorld.h"

#import "SBMenu.h"

@class GameWorld;
@class SatelliteBullet;

static GLuint texture;
static GLuint texture2;

static NSMutableArray * satellites;

static int price;

@interface Satellite : GameObject {
@private
    bool shouldFire;
    float targetRotation;
    bool beingPlaced;
    bool placementStarted;
    SatelliteBullet * bullet;
    float scale;
    bool isUnderControl;
    GameObject * manualTarget;
	double endTime;
	float color;
}
+(void)load;
- (id)initWithX:(float)tempX andY:(float)tempY;
-(void)draw;
-(void)fire;
-(void)update:(double)time;
+(NSMutableArray*)getSatellites;
-(void)removeNotification;
-(int)checkX:(float)x1 checkY:(float)y1;
+(void)draw;
+(int)getPrice;
+(void)initList;
+(void)reset;
-(void)fireAtTarget:(GameObject*)t;

+(void)fireAllAtTarget:(GameObject*)t;


@property bool beingPlaced;
@property bool placementStarted;
@property float scale;
@property float color;
@end
