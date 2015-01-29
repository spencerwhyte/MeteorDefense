//
//  credits.h
//  TD
//
//  Created by Mark corbelli on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loader.h"
#import "GameWorld.h"

float width;
float height;
bool firstUpdate2; // Whether or not this is the first frame update
static GLuint exitButton;
static GLuint creditsBackground;


@interface Credit : NSObject {
@private
    
}

+(void)draw;
+(void)load;
+ (void)touchesBeganX:(float)x andY:(float)y;

+ (void)touchesMovedX:(float)x andY:(float)y;

+ (int)touchesEndedX:(float)x andY:(float)y;
+ (void)touchesCancelledX:(float)x andY:(float)y;
-(void)pause;
-(void)reset;


@end
