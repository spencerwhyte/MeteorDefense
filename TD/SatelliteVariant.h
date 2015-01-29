//
//  SatelliteVariant.h
//  TD
//
//  Created by Spencer Whyte on 11-02-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "SatelliteBullet.h"
#import "GameWorld.h"

@class GameWorld;
@class SatelliteBulletVariant;

static GLuint texture;
static GLuint texture2;

static NSMutableArray * satelliteVariants;
static  int price;
@interface SatelliteVariant : GameObject{
@private
    bool shouldFire;
    float targetRotation;
    bool beingPlaced;
    bool placementStarted;
    SatelliteBulletVariant * bullet;
    float scale;
    bool isUnderControl;
   
    GameObject *manualTarget;
    
    
    bool loaded;
    float color;
    double reloadTime;
	double endTime;
}
+(void)load;
- (id)initWithX:(float)tempX andY:(float)tempY;
-(void)draw;
-(void)fire;
-(void)update:(double)time;
+(NSMutableArray*)getSatelliteVariants;
-(void)removeNotification;
-(int)checkX:(float)x1 checkY:(float)y1;
+(void)draw;
+(void)initList;
+(int)getPrice;
+(void)reset;
-(void)fireAtTarget:(GameObject*)t;
+(void)fireAllAtTarget:(GameObject*)t;
@property bool beingPlaced;
@property bool placementStarted;
@property float scale;
@property bool loaded;
@property float color;
@end
