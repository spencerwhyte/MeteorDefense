//
//  ParticleSystem.m
//  TD
//
//  Created by Spencer Whyte on 11-02-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParticleSystem2.h"



@implementation ParticleSystem2

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}








+(void)registerElectricityBetweenObject2:(GameObject*)g1{
    NSLog(@"Register");
    [gameObjects1 addObject:g1];
}


static  GLfloat p [PARTICLECOUNT*2];

double lastTime;

+(void)draw2{
    double timeDiff2 = CACurrentMediaTime() - lastTime; 
    
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    for(int i = 0 ; i < [explosionsX count] ; i++){
        double timeDiff = CACurrentMediaTime() - [[explosionsT objectAtIndex:i] doubleValue];
        int type = [[explosionsType objectAtIndex:i] intValue];
        if(type == 0){
            glColor4f(1.0 - timeDiff*2, 0.2f+  0.5 - timeDiff,  0.5 - timeDiff +0.2f, 1.0f);
        }else if(type == 1){
            glColor4f(0.2f+  0.5 - timeDiff ,   1.0 - timeDiff*2    ,  0.5 - timeDiff +0.2f, 1.0f);
        }else if(type == 2){
            glColor4f(0.2f+  0.5 - timeDiff ,    0.5 - timeDiff +0.2f    ,  1.0 - timeDiff*2    , 1.0f);
        }
        glPushMatrix();
        glTranslatef([[explosionsX objectAtIndex:i] floatValue], [[explosionsY objectAtIndex:i] floatValue], 0);
        float dist =( 1 - 2 *((0.7 - timeDiff)*(0.7- timeDiff))) *10;
        for(int j = 0  ; j<PARTICLECOUNT; j ++){
            p[2*j] = dX[j]* dist;
            p[2*j+1]  =dY[j]* dist;
        }
        glVertexPointer(2, GL_FLOAT, 0, p);
        glDrawArrays(GL_POINTS, 0, PARTICLECOUNT);
        glPopMatrix();

    }
	glColor4f(0.5, 0.5,1.0, 1.0);
	p[0] = 0.0f;
	p[1] = 0.0; 
	for(int j = 1 ; j<PARTICLECOUNT; j ++){
		p[j*2] = j;
		p[j*2+1] = p[(j-1)*2+1] +(rand()%3) - 1;
	}
	float x1;
	float y1;
	float x2;
	float y2;
	for(int i = 0 ; i < [gameObjects1 count] ;i++){
		glPushMatrix();
		GameObject * g1 = [gameObjects1 objectAtIndex:i];
		x1 = 15.0f;  
		y1 = g1.y;
		x2 = width-15.0f;
		y2 = g1.y;
		float dist = sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
        
		glTranslatef(x1, y1, 0);
		glRotatef(-90+ (180*atan2f( ( x2-x1) / dist ,( y1 - y2) / dist )/3.14159265) , 0.0, 0.0, 1.0);
		glVertexPointer(2, GL_FLOAT, 0, p);
		int temp;
		if(dist< 50){
			temp= (int)floor(dist);
		}else{
			temp =PARTICLECOUNT;
		}
		glDrawArrays(GL_POINTS, 0, temp);
		glPopMatrix();
		
		if(true){
            if(g1.remove){
				
                [gameObjects1 removeObjectAtIndex:i];
            }
        }
        
    }
    
    
    
    
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glColor4f(1.0, 1.0f, 1.0f, 1.0f);
    
    
    
}



@end
