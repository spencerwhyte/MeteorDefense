//
//  Asteroid.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "GameWorld.h"
#import "CometData.h"
@class CometData;

static NSMutableArray *comets;
static NSMutableArray *cometsData;
static GLuint texture;
static bool finalComet1;
static double time1;
static double time2;

@interface finalComet : GameObject {
@private
    CometData *data;
    float rotationDifference;
    float scale;
	float scale2;
	float scale3;
    float speed;
	float w1;
	float w2;
	float w3;
	int i;
    bool shouldHighlight;
    bool inElectricField;
	bool scale3b;
	float transx;
	//float rotation;
	//float y;
	
}

-(void)draw;
-(void)update:(double)time;
+(void)load;
-(id)init;
+(NSMutableArray *)getComets;
-(void)removeNotification;
+(void)draw;
-(void)setShouldHighlight:(bool)h;
+(void)reset;
@property float speed;
@property bool shouldHighlight;
@property bool inElectricField;
@end
