//
//  AsteroidData.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CometData.h"


@implementation CometData

- (id)init {
    if ((self = [super init])) {

        /*
		 for(int  i = 0; i < 18; i++){
		 data[i*6]   *=15.0;
		 data[i*6+1] *=15.0;
		 data[i*6+2] *=15.0;
		 data[i*6+3] *=15.0;
		 data[i*6+4] *=15.0;
		 data[i*6+5] *=15.0;
		 }
		 */
    }
    return self;
}

+(void)load{
}

static  const GLfloat standard[] = {
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f,  0.0f,
    1.0f,  0.0f,
};

-(void)draw{
	const GLfloat sv[] = {
		0.0f, 1.0f,
		1.0f, 1.0f,
		0.0f, 0.0f,
		1.0f, 0.0f
	};
	
	
    glPushMatrix();
	glScalef(30.0, 30.0, 1.0f);
	//glTranslatef(width*0.50, height, 0.0);
	glVertexPointer(2, GL_FLOAT, 0,sv);
	glTexCoordPointer(2, GL_FLOAT,0 , standard);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
    // glEnable(GL_BLEND);
	
    if(shouldHighlight){
		glDisable(GL_TEXTURE_2D);
		glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		glColor4f(0.7f, 0.7f, 1.0f, 1.0f);
		glVertexPointer(2, GL_FLOAT, 6*sizeof(GLfloat),data);    
		glDrawArrays(GL_LINE_LOOP,0, 18);
		glEnable(GL_TEXTURE_2D);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glEnableClientState(GL_VERTEX_ARRAY);
    }else{
        glDisable(GL_TEXTURE_2D);
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
        glColor4f(1.0, 1.0f, 1.0f, 1.0f);
        glVertexPointer(2, GL_FLOAT, 6*sizeof(GLfloat),data);    
        glDrawArrays(GL_LINE_LOOP,0, 18);
        glEnable(GL_TEXTURE_2D);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnableClientState(GL_VERTEX_ARRAY);
    }
    glPopMatrix();
	glColor4f(1.0, 1.0f, 1.0f, 1.0f);
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@synthesize shouldHighlight;
@end
