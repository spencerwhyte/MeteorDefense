//
//  Asteroid.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsteroidData.h"
#import "GameObject.h"
#import "GameWorld.h"
#import "Score.h"
@class AsteroidData;

static NSMutableArray *asteroids;
static NSMutableArray *asteroidData;
static GLuint texture;
@interface Asteroid : GameObject {
@private
    AsteroidData *data;
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
+(NSMutableArray *)getAsteroids;
-(void)removeNotification;
+(void)draw;
-(void)setShouldHighlight:(bool)h;
+(void)reset;
@property float speed;
@property bool shouldHighlight;
@property bool inElectricField;
@end
