//
//  GameObject.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loader.h"

@interface GameObject : NSObject {
@private
    float x;
    float y;
    bool remove;
        float rotation;
      bool hasDrawnClass;
    bool mobile;
}
-(void)touchX:(float)x touchY:(float)y;
-(void)draw;
- (id)init;
- (id)initWithX:(float)tempX andY:(float)tempY;
-(void)removeNotification;
-(void)update:(double)time;

-(int)checkX:(float)x1 checkY:(float)y1;


- (void)touchesBeganX:(float)x andY:(float)y;
- (void)touchesMovedX:(float)x andY:(float)y;
- (void)touchesEndedX:(float)x andY:(float)y;
- (void)touchesCancelledX:(float)x andY:(float)y;

@property float x;
@property float y;
@property bool remove;
@property float rotation;
@property bool mobile;
@end
