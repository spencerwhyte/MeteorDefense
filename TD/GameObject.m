//
//  GameObject.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject



- (id)init {
    if ((self = [super init])) {
        x = 0.0f;
        y = 0.0f;
                self.rotation = 0.0f;
        hasDrawnClass = false;
        remove = false;
        mobile = true;
    }
    return self;
}
-(void)touchX:(float)x touchY:(float)y{
    
}


- (void)touchesBeganX:(float)x andY:(float)y{
   
}
- (void)touchesMovedX:(float)x andY:(float)y{
   
}
- (void)touchesEndedX:(float)x andY:(float)y{  
}
- (void)touchesCancelledX:(float)x andY:(float)y{
    
}



-(void)removeNotification{
    
}
-(int)checkX:(float)x1 checkY:(float)y1{
    return -1; 
}

- (id)initWithX:(float)tempX andY:(float)tempY{
    if ((self = [super init])) {
        x = tempX;
        y = tempY;
        remove = false;
                self.rotation = 0.0f;
        hasDrawnClass  =false;
             mobile = true;
    }
    return self;
}

-(void)draw{


}


-(void)update:(double)time{
    
    
}




- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@synthesize x;
@synthesize y;
@synthesize remove;
@synthesize rotation;
@synthesize mobile;
@end
