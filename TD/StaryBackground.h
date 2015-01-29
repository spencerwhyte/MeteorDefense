//
//  StaryBackground.h
//  TD
//
//  Created by Spencer Whyte on 11-03-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loader.h"
#import "GameWorld.h"

#define STARCOUNT   100


static GLfloat positions[STARCOUNT + STARCOUNT];
static GLfloat sizes[STARCOUNT];
static GLfloat twinkleProgress[STARCOUNT];

@interface StaryBackground : NSObject {
@private
    
}
+(void)loads;
+(void)update:(double)time;
+(void)draw;
@end
