//
//  SpaceBase.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpaceBase.h"


@implementation SpaceBase

- (id)init {
    if ((self = [super init])) {
   
    }
    
    return self;
}


+(void)load{
    
    texture = [Loader loadImageWithName:@"SpaceBase.png"];

}


- (id)initWithX:(float)tempX andY:(float)tempY{
    if ((self =    [super initWithX:tempX andY:tempY])) {
        s = self;
        self.x = tempX;
        self.y = tempY;
        timeOfFirstTouch = CACurrentMediaTime();
    }
    return self;
}




+(SpaceBase*)spaceBase{
    return s;
}



+(void)reset{
    
}



- (void)touchesBeganX:(float)x andY:(float)y{
    timeOfFirstTouch = CACurrentMediaTime();
  
}
- (void)touchesMovedX:(float)x andY:(float)y{

}
- (void)touchesEndedX:(float)x andY:(float)y{
    timeOfFirstTouch = CACurrentMediaTime() - 10.0;
}
- (void)touchesCancelledX:(float)x andY:(float)y{
    
}

/*+(void)setmen3True{
	men3=true;
}*/
+(void)setmen3False{
	men3=false;
}
+(void)setmen5False{
	men5=false;
}

-(int)checkX:(float)x1 checkY:(float)y1{
	//if(men3==false){
    if(men3 == false && x1 < self.x +width*0.2&& x1 > self.x - width*0.2 && y1 < self.y + height*0.05 && y1 > self.y -height*0.05){
		men3=true;
		[SBMenu setMenuFalse];
		return 8;
		//NSLog(@"Test3");
	//}
	} else if (men5==true){
		[SBMenu setMenuTrue];
		//NSLog(@"test");
	}
	if(men3==true && men5==false){
		//NSLog(@"test4");
		men5=true;
	}
	if(men5==true && men3==true){
		men3=false;
	}
	NSLog(@"%i", men3);
    return-1;
}




static  const GLfloat svt[] = {
    0.0f, 0.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    1.0f,  1.0f,
};

+(void)draw{
    const GLfloat sv[] = {
        -width*0.22, height*0.04,
        width*0.22, height*0.04,
        -width*0.22,  -height*0.04,
        width*0.22,  -height*0.04
    };
    glPushMatrix();
    glTranslatef(s.x, s.y,0);
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    glBindTexture(GL_TEXTURE_2D, texture);
	glVertexPointer(2, GL_FLOAT, 0,sv);
	glTexCoordPointer(2, GL_FLOAT,0 , svt);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPopMatrix();
    
    
}


-(void)update:(double)time{
    float diff = CACurrentMediaTime() - timeOfFirstTouch;
    if( diff > 0.5 && diff < 0.6){
        if([SBMenu currentMenu] == nil && moveObject ==nil){
            SBMenu * m = [[SBMenu alloc ] init];
            [ objects addObject: m];
            [m release];
            timeOfFirstTouch = CACurrentMediaTime() -10.0;
        }
    }
    
    
}

-(void)removeNotification{
    
    
    
}


- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
