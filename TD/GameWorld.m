//
//  GameWorld.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameWorld.h"


@implementation GameWorld

- (id)initWithWidth:(float)tempWidth andHeight:(float)tempHeight {
    if ((self = [super init])) {
        
        width = tempWidth;
        height = tempHeight;
  
                //Load classes
        [Satellite load];
        [Asteroid load];
        [AsteroidData load];
        [SpaceBase load];
        [SatelliteBullet load];
        [SBMenu load];
		[SubMenu load];
        [SatelliteVariant load];
        [SatelliteBulletVariant load];
        [ElectricFence load];
        [FusionCoil load];
        [Score load];
		[CometData load];
		[finalComet load];
             // NSLog(@"blah");
        [StaryBackground loads];
        objects = [[NSMutableArray alloc ]init];
        
        SpaceBase * s2 = [[SpaceBase alloc] initWithX:width /2.0 andY:height/1.5];
        [objects addObject:s2];
        [s2 release];
        
     
        
        
        glEnable(GL_TEXTURE_2D);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glEnableClientState(GL_VERTEX_ARRAY);
        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
          glPointSize(2.0);
        
        firstUpdate = true;
        
        moveObject = nil;
        
        texture = [Loader loadImageWithName:@"earthSprite.png"];
		texture3 = [Loader loadImageWithName:@"Quit.png"];
        texture2 = [Loader loadImageWithName:@"starBackground.png"];

        
        
    }
    return self;
}

-(void)reset{
       firstUpdate= true;
        [objects release];
        objects = [[NSMutableArray alloc ]init];
        moveObject = nil;
    
    SpaceBase * s2 = [[SpaceBase alloc] initWithX:width /2.0 andY:height/1.5];
    [objects addObject:s2];
    [s2 release];
    
    
    [Satellite reset];
    [Asteroid reset];
	[finalComet reset];
    [SpaceBase reset];
    [SatelliteBullet reset];
    [SBMenu reset];
    [SatelliteVariant reset];
    [SatelliteBulletVariant reset];
    [ElectricFence reset];
    [FusionCoil reset];
    [Score reset];
    [ParticleSystem reset];
}

-(void)pause{
    firstUpdate = true;
}

-(BOOL)withinX:(float)x withinY:(float)y{
    return TRUE;
}

-(void)touchX:(float)x touchY:(float)y{
    /*
     Satellite * s = [[Satellite alloc] initWithX:x andY:y];
     [objects addObject:s];
     [s release];
     */
    NSLog(@"\n\n");
}

bool moveTouches;


- (void)touchesBeganX:(float)x andY:(float)y{
    GameObject * best = nil;
    int priority = 0;
    for(GameObject * o in objects){
        int temp =[o checkX:x checkY:y];
        if(temp > priority ){
            best  = o;
            priority = temp;
        }
    }
    if(best!=nil){
        [best touchesBeganX:x andY:y];
    }else{
      //  NSLog(@"%d", [ retainCount]);
        GameObject * m = [[GameObject alloc] initWithX:x andY:y ];
         [Satellite fireAllAtTarget:m];
        [SatelliteVariant fireAllAtTarget:m];
        [m release];
    }
   
    
    
    
}
- (void)touchesMovedX:(float)x andY:(float)y{
    if(moveObject !=nil){
        [moveObject touchesMovedX:x andY:y];
    }
}
- (void)touchesEndedX:(float)x andY:(float)y{
    GameObject * best = nil;
    int priority = 0;
    for(GameObject * o in objects){
        int temp =[o checkX:x checkY:y];
        if(temp > priority ){
            best  = o;
            priority = temp;
        }
    }
    if(best!=nil){
        [best touchesEndedX:x andY:y];
    }
}
- (void)touchesCancelledX:(float)x andY:(float)y{
    GameObject * best = nil;
    int priority = 0;
    for(GameObject * o in objects){
        int temp =[o checkX:x checkY:y];
        if(temp > priority ){
            best  = o;
            priority = temp;
        }
    }
    if(best!=nil){
        [best touchesCancelledX:x andY:y];
    }
}

static int max(double x, double y){
    if(y<x){
        return (int)x;
    }
    return (int)y;
}


-(void)update{
    if(firstUpdate2){
        lastTime = CACurrentMediaTime();
        firstUpdate2 = false;
    }
    
    
    
    if(firstUpdate ){
        lastTime = CACurrentMediaTime();
        levelStart = lastTime;
        firstUpdate = false;
    }else{
         if(lastTime - levelStart < 5.0){
           if([objects count] <2){
                 levelStart = CACurrentMediaTime();
           }
         }
        if(rand() %max((int)(20 -((lastTime -levelStart)/20.0)),1) == 0){
            
            if(lastTime - levelStart > 5.0 && [Score getEarthHealth]>=20){
               Asteroid* a = [[Asteroid alloc] initWithX: rand()% ((int)width) andY:0.0];
                [objects addObject:a];
                [a release];
				if([Score getEarthHealth] == 20){
					meteorsEnded1=CACurrentMediaTime();
				}
            }
		 else if(lastTime - meteorsEnded1 > 5.0 &&[Score getEarthHealth]<20){
				finalComet* c = [[finalComet alloc] initWithX: rand()% ((int)width) andY:0.0];
				[objects addObject:c];
				[c release];
			}
		}
	/*	if(rand() %max((int)(20 -((lastTime -levelStart)/20.0)),1) == 0 && [Score getEarthHealth] <20){
            
            if(lastTime - levelStart > 5.0){
				finalComet* c = [[finalComet alloc] initWithX: rand()% ((int)width) andY:0.0];
                [objects addObject:c];
                [c release];
            }
        }*/
        for(int i  =0  ; i< [objects count] ; i++){
            if( ((GameObject*)[objects objectAtIndex:i]).remove == true){
                [((GameObject*)[objects objectAtIndex:i]) removeNotification];
                [objects removeObjectAtIndex:i];
            }
        }
        double time =CACurrentMediaTime();
        double gameTime = 1000*(time - lastTime); 
        lastTime = time;
        for(int i = 0; i < [objects count]; i++){
            GameObject * g = [objects objectAtIndex:i];
            [g update:gameTime];
        }
        [StaryBackground update:gameTime];
    }
}


-(void)draw{
	//[Sounds playsound:@"Ambiento"];
    const GLfloat sv[] = {
        -width/2.0, height*0.1,
        width/2.0, height*0.1,
        -width/2.0,-height*0.1,
        width/2.0, -height*0.1
    };
    
    
    static  const GLfloat svt[] = {
        0.0f, 0.0f,
        1.0f, 0.0f,
        0.0f,  1.0f,
        1.0f,  1.0f,
    };
    
   static const GLfloat sv3[] = {
	0.0f,0.0f,
	1.0f,0.0f,
	0.0f,1.0f,
	   1.0f,1.0f
	};
    const GLfloat sv2[] = {
        -width, height*0.8,
        width, height*0.8,
        -width,0,
        width, 0
    };
    
    
  
    
    
    glPushMatrix();
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    glTranslatef(width-5.0, height - height*0.1, 0);
    glBindTexture(GL_TEXTURE_2D, texture3);
	glVertexPointer(2, GL_FLOAT, 0,sv3);
	glTexCoordPointer(2, GL_FLOAT,0 , svt);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPopMatrix();
	
	glPushMatrix();
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    glTranslatef(width/2.0, height - height*0.1, 0);
    glBindTexture(GL_TEXTURE_2D, texture);
	glVertexPointer(2, GL_FLOAT, 0,sv);
	glTexCoordPointer(2, GL_FLOAT,0 , svt);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPopMatrix();    
   // [Audio playSound:@"Ambiento"];
    [StaryBackground draw];
    [Satellite draw];
    [SatelliteVariant draw];
    [ElectricFence draw];
    [Asteroid draw];
	[finalComet draw];
    [SpaceBase draw];
    [SatelliteBullet draw];
    [SatelliteBulletVariant draw];
    [FusionCoil draw];
    [Score draw];
    [Score draw];
    [SBMenu draw];
}


- (void)dealloc {
    // Clean-up code here.
    [objects release];
    [super dealloc];
}
@end
