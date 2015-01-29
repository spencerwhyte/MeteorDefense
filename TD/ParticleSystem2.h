//
//  ParticleSystem.h
//  TD
//
//  Created by Spencer Whyte on 11-02-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Loader.h"
#import "GameObject.h"
#import "Asteroid.h"
#import "ElectricFence.h"

static NSMutableArray * explosionsX;
static NSMutableArray * explosionsY;
static NSMutableArray * explosionsT;
static NSMutableArray * explosionsType; 

static NSMutableArray * gameObjects1;// Holds one game object from the pair of game objects that there is electricity between
static NSMutableArray * gameObjects2; // Holds one game object from the pair of game objects that there is electricity between
static NSMutableArray * maxDistances; // holds the maximum distance that the objects should have electricity drawn between them at


#define PARTICLECOUNT   50

static float dX[PARTICLECOUNT];
static float dY[PARTICLECOUNT];



@interface ParticleSystem2 : NSObject {
@private
    
}
+(void)registerExplosionX:(float)x andY:(float)y andType:(int)type;
+(void)registerElectricityBetweenObject:(GameObject*)g1 andObject:(GameObject*)g2 withMaxDistance:(int)maxDistance;
+(void)load;
+(void)draw;
+(void)reset;
@end
