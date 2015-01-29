//
//  AsteroidData.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsteroidData.h"


@implementation AsteroidData

- (id)init {
    if ((self = [super init])) {
        float previousRandomX  =0.0;
        float previousRandomY = 0.0;
        data[0] = 0.0f;
        data[1] = 1.0f;
        data[2] = 0.0f;
        data[3] = 0.0f;
        data[4] = -0.1f;
        data[5] = 1.0f;
        
        for(int  i = 1; i < 18; i++){
            data[i*6] =   0.5*sin((i / 18.0) * 2* 3.1415926535);
            float tempRX = (rand()%10)/20.0;
            float tempRY = (rand()%10)/20.0;
            data[i*6] +=   0.5*(tempRX + (previousRandomX /2.0));
            data[i*6+1] = 0.5*cos((i / 18.0) * 2* 3.1415926535);
            data[i*6+1] += 0.5*( tempRY + (previousRandomY/2.0));
            data[i*6 + 2] = 0.0;
            data[i*6 + 3] = 0.0;
            data[i*6 + 4] = data[(i-1)*6];
            data[i*6 + 5] = data[(i-1)*6+1];
            previousRandomX = tempRX;
            previousRandomY = tempRY;
		}
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

-(void)draw{

    glPushMatrix();

   
    glScalef(30.0, 30.0, 1.0f);
	glVertexPointer(2, GL_FLOAT, 0,data);
	glTexCoordPointer(2, GL_FLOAT,0 , data);    
    glDrawArrays(GL_TRIANGLES, 0, 56);
    
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
