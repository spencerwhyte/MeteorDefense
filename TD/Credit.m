//
//  credits.m
//  TD
//
//  Created by Mark corbelli on 4/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Credit.h"


@implementation Credit

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}



+ (void)touchesBeganX:(float)x andY:(float)y{
    if( y > 0.0 && y < height){
        selectedMenuItem = 1;
		
    }else{
        selectedMenuItem = -1;
    }
}

+ (void)touchesMovedX:(float)x andY:(float)y{
	
}

+ (int)touchesEndedX:(float)x andY:(float)y{
    selectedMenuItem = -1;
    if(y >0.0 && y < height){
		return 1;
    }
    return 0;
    
}

+ (void)touchesCancelledX:(float)x andY:(float)y{
	
}



static  const GLfloat svt2[] = {
	
    
    0.0f, 0.35f,
    1.0f, 0.35f,
    0.0f,  0.0f,
    1.0f,  0.0f,
	
};
/*

static  const GLfloat svt[] = {
    
    
    
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.0f,
    1.0f,  0.0f,
};
*/



static  const GLfloat standard[] = {
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.0f,
    1.0f,  0.0f,
};
static  const GLfloat svt[] = {
    
    
    
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.35f,
    1.0f,  0.35f,
};




float menuY;
+(void)load{
    
    creditsBackground  = [Loader loadImageWithName:@"creditPage.png"];
	
    selectedMenuItem = -1;
}
+(void)draw{
	const GLfloat sv[] = {
		0.0, 0.0,
		width, 0.0,
		0.0, height,
		width, height
	};
	const GLfloat standard[] = {
		0.0f, 0.0f,
		1.0f, 0.0f,
		0.0f,  -1.0f,
		1.0f,  -1.0f,
	};
	
	
	
	glPushMatrix();
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	glBindTexture(GL_TEXTURE_2D,creditsBackground);
	glTranslatef(0.0f, 0.0f, 0.0f);
	glVertexPointer(2, GL_FLOAT, 0,sv);
	glTexCoordPointer(2, GL_FLOAT,0 , standard);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	glPopMatrix();}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@end
