//
//  Satellite.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "GameWorld.h"

@class GameWorld;


static GLuint texture;
static GLuint texture2;

static NSMutableArray * electricFences;
NSMutableArray *targetObjects;
static int price;
#define ELECTRICCOUNT 300
static GLfloat electricData [ELECTRICCOUNT];


@interface ElectricFence : GameObject {
@private
	double endTime;

    float targetRotation;
    float color;
    bool beingPlaced;
    bool placementStarted;
    float scale;
    
    bool isUnderControl;
    
    int hostLimit;
    GameObject *targetObject;
    float lockx;
    float locky;
    
}
+(void)load;

- (id)initWithX:(float)tempX andY:(float)tempY;

-(void)draw;

-(void)update:(double)time;

+(NSMutableArray*)getElectricFences;

-(void)removeNotification;

-(int)checkX:(float)x1 checkY:(float)y1;

+(void)draw;

+(int)getPrice;

+(void)initList;

-(void)notifyElectricityRemoval;

+(void)reset;
@property bool beingPlaced;
@property bool placementStarted;
@property float scale;
@property float color;
@end
