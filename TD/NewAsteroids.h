//
//  Asteroid.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewAsteroidData.h"
#import "GameObject.h"
#import "GameWorld.h"
#import "Score.h"
@class NewAsteroidData;

static NSMutableArray *newasteroids;
static NSMutableArray *newasteroidData;
static float asteroidHealth;
static GLuint texture;
@interface NewAsteroids : GameObject {
@private
    NewAsteroidData *data;
    float rotationDifference;
    float scale;
    float speed;
	float speed2;
	float speed3;
	int i;
    bool shouldHighlight;
    bool inElectricField;
	
}
//bool finalComet;
-(void)draw;
-(void)update:(double)time;
+(void)load;
-(id)init;
+(NSMutableArray *)getNewAsteroids;
-(void)removeNotification;
+(void)draw;
-(void)setShouldHighlight:(bool)h;
+(void)changeAsteroidHealth:(float)astrdhealth;
+(float)getAsteroidHealth;
+(void)reset;
@property float speed;
@property bool shouldHighlight;
@property bool inElectricField;
@end
