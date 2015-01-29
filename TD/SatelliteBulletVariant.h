//
//  SatelliteBulletVariant.h
//  TD
//
//  Created by Spencer Whyte on 11-02-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "Asteroid.h"
#import "ParticleSystem.h"

static NSMutableArray * bullets;
static GLuint texture;
@interface SatelliteBulletVariant : GameObject {
@private
    float dx;
    float dy;
}
- (id)initWithX:(float)tempX andY:(float)tempY andDx:(float)tempDx andDy:(float)tempDy;
+(void)draw;
-(void)removeNotification;
+(void)load;
+(void)reset;
@end
