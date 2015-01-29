//
//  SpaceBase.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

#import "SBMenu.h"
#import "GameWorld.h"
@class SpaceBase;

static GLuint texture;
static bool men3;
static bool men5;
SpaceBase * s;

@interface SpaceBase : GameObject {
@private
   double timeOfFirstTouch;
}
+(void)load;
- (id)initWithX:(float)tempX andY:(float)tempY;
+(void)setmen3False;
+(void)setmen5False;
+(void)draw;
-(void)fire;
-(void)update:(double)time;
-(void)removeNotification;
+(SpaceBase*)spaceBase;
+(void)reset;
@end
