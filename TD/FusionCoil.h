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

static NSMutableArray * fusionCoils;

static int price;
static int Limit;

@interface FusionCoil : GameObject {
@private
    
    float targetRotation;
    
    bool beingPlaced;
    bool placementStarted;
    float scale;
    
    bool isUnderControl;
    
    int hostLimit;
	
    NSMutableArray *targetObjects;
    double endTime;
    float color;
}
+(void)load;

- (id)initWithX:(float)tempX andY:(float)tempY;

//static int count;
-(void)draw;

-(void)update:(double)time;

+(NSMutableArray*)getFusionCoils;

-(void)removeNotification;

-(int)checkX:(float)x1 checkY:(float)y1;

+(void)draw;

+(int)getPrice;

+(void)initList;
+(void)reset;

@property bool beingPlaced;
@property bool placementStarted;
@property float scale;
@property float color;
@end
