//
//  ParticleSystem.m
//  TD
//
//  Created by Spencer Whyte on 11-02-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ParticleSystem.h"



@implementation ParticleSystem

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}


+(void)registerExplosionX:(float)x andY:(float)y andType:(int)type {
    NSNumber * n1 = [[NSNumber alloc] initWithFloat:x];
    NSNumber * n2 = [[NSNumber alloc] initWithFloat:y];
    NSNumber *n3 = [[NSNumber alloc] initWithDouble:CACurrentMediaTime()];
    NSNumber * n4 = [[NSNumber alloc] initWithInt:type];
    [explosionsX addObject:n1];
    [explosionsY addObject:n2];
    [explosionsT addObject:n3];
    [explosionsType addObject:n4];
    
    [n1 release];
    [n2 release];
    [n3 release];
    [n4 release];
}


+(void)registerElectricityBetweenObject2:(GameObject*)g1{
    NSLog(@"Register");
    [gameObjects1 addObject:g1];
//    NSNumber * n = [[NSNumber alloc] initWithInt:maxDistance];
 //   [maxDistances addObject:n];
   // [n release];    
	rebo2=true;
}




+(void)registerElectricityBetweenObject:(GameObject*)g1 andObject:(GameObject*)g2 withMaxDistance:(int)maxDistance{
    NSLog(@"Register");
    ((Asteroid*)g2).shouldHighlight = true;
    [gameObjects1 addObject:g1];
    [gameObjects2 addObject:g2];
    NSNumber * n = [[NSNumber alloc] initWithInt:maxDistance];
    [maxDistances addObject:n];
    [n release];   
	rebo2=false;
}


static  GLfloat p [PARTICLECOUNT*2];

double lastTime;

+(void)draw{
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
        if(timeDiff > 0.4){
            [explosionsT removeObjectAtIndex:i];
            [explosionsX removeObjectAtIndex:i];
            [explosionsY removeObjectAtIndex:i];
            [explosionsType removeObjectAtIndex:i];
        }
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
            GameObject * g2  = [gameObjects2 objectAtIndex:i];
            x1 = g1.x;  
            y1 = g1.y;
            x2 = g2.x;
            y2 = g2.y;
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
            if(dist > [[maxDistances objectAtIndex:i] intValue] || g2.remove || g1.remove){
               ((Asteroid*) [gameObjects2 objectAtIndex:i]).shouldHighlight = false ;
               
                [gameObjects1 removeObjectAtIndex:i];
                [gameObjects2 removeObjectAtIndex:i];
                [maxDistances removeObjectAtIndex:i];
            }
        }
        
    }
    
	if(rebo2==true){
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
    }
    
    
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glColor4f(1.0, 1.0f, 1.0f, 1.0f);
    
    
    
}

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

    
    
    
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glColor4f(1.0, 1.0f, 1.0f, 1.0f);
    
    
    
}


+(void)load{
    explosionsX = [[NSMutableArray alloc] init];
    explosionsY = [[NSMutableArray alloc] init];
    explosionsT = [[NSMutableArray alloc] init];
    explosionsType = [[NSMutableArray alloc] init];
    for(int  i = 0 ; i < PARTICLECOUNT; i++){
        float f = rand()%3600;
        f = (f /3600.0f)* 2*3.1415926;
        dX[i] = sin(f);
        dY[i] = cos(f);
        f = rand()%3600;
        f = (f /180.0f);
        dX[i]*= f+2;
        dY[i]*= f+2;
    }
    gameObjects1 = [[NSMutableArray alloc] init];
    gameObjects2 = [[NSMutableArray alloc] init];
    maxDistances = [[NSMutableArray alloc] init];
    
    
}


+(void)reset{
    [explosionsX release];
          [explosionsY release];
          [explosionsT release];
          [explosionsType release];
    explosionsX = [[NSMutableArray alloc] init];
  
    explosionsY = [[NSMutableArray alloc] init];
    explosionsT = [[NSMutableArray alloc] init];
    explosionsType = [[NSMutableArray alloc] init];
   
    [gameObjects1 release];
    [gameObjects2 release];
    [maxDistances release];
    gameObjects1 = [[NSMutableArray alloc] init];
    gameObjects2 = [[NSMutableArray alloc] init];
    maxDistances = [[NSMutableArray alloc] init];
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
