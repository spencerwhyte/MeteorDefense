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
@class CometData;

static NSMutableArray *comets;
static NSMutableArray *cometsData;
static GLuint texture;
@interface Comet : GameObject {
@private
   CometData *data;
    float rotationDifference;
    float scale;
    float speed;
    bool shouldHighlight;
    bool inElectricField;
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
