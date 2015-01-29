//
//  Satellite.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Satellite.h"

@implementation Satellite

- (id)init {
    if ((self = [super init])) {
        shouldFire =false;
        [satellites addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        bullet = nil;
        scale = 1.0;
        
        [Score changeCredits:-1*[Satellite getPrice]];  
        
        isUnderControl = false;
          manualTarget = nil;
        
    }
    
    return self;
}


- (id)initWithX:(float)tempX andY:(float)tempY{
    
    if ((self =    [super initWithX:tempX andY:tempY])) {
        
        shouldFire = false;
        [satellites addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        bullet = nil;
        scale = 1.0;
        
        [Score changeCredits:-1*[Satellite getPrice]];  
        
        isUnderControl = false;
        manualTarget = nil;
        
    }
    
    return self;
}

-(void)fire{
    shouldFire = true;
}


+(void)load{
    texture = [Loader loadImageWithName:@"Satellite.png"];
    texture2 = [Loader loadImageWithName:@"satallitePlace.png"];
    satellites = [[NSMutableArray alloc] init ];
    price = 100;
}

+(void)reset{
    [satellites release];
    satellites = [[NSMutableArray alloc] init ];
}


+(int)getPrice{
    return price;
}

-(void)draw{
    /*
     static const GLfloat sv[] = {
     -0.5f, -0.5f,-10.0,
     0.5f, -0.5f,-10.0,
     -0.5f,  0.5f,-10.0,
     0.5f,  0.5f,-10.0
     };
     
     static  const GLfloat svt[] = {
     0.0f, 0.0f,
     1.0f, 0.0f,
     0.0f,  1.0f,
     1.0f,  1.0f,
     };
     glPushMatrix();
     
     glTranslatef(self.x, self.y,0);
     glRotatef(self.rotation, 0.0f, 0.0f, 1.0);
     glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
     glBindTexture(GL_TEXTURE_2D, texture);
     glVertexPointer(3, GL_FLOAT, 0,sv);
     glTexCoordPointer(2, GL_FLOAT,0 , svt);
     glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
     glPopMatrix();
     */
    
}


-(int)checkX:(float)x1 checkY:(float)y1{
    
    if(beingPlaced){
        return 10;
    }
    
    if([SBMenu manualControlSelect] ){
        
        float dist = sqrt((self.x - x1 ) * (self.x - x1 ) + (self.y - y1 )*(self.y - y1 ));
        if(dist < 200){
            return (200 - dist);
        }
    }
    if(isUnderControl){
        
        return 5;
    }
    return -1;
}







static  const GLfloat svt[] = {
    0.0f, 0.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    1.0f,  1.0f,
};

+(void)draw{
    const GLfloat sv[] = {
        -width*0.06125, -  width*0.06125,
        width*0.06125, -  width*0.06125,
        -width*0.06125,   width*0.06125,
        width*0.06125,    width*0.06125
    };
    
    glBindTexture(GL_TEXTURE_2D, texture);
    glVertexPointer(2, GL_FLOAT, 0,sv);
    glTexCoordPointer(2, GL_FLOAT,0 , svt);
    for(int i = 0; i < [satellites count] ; i++){
        
        Satellite *s  = [satellites objectAtIndex:i];
        if(s.placementStarted){
            if(s.beingPlaced){
                glBindTexture(GL_TEXTURE_2D, texture2);
                
            }
            glPushMatrix();
            glTranslatef(s.x, s.y,0);
            glScalef(s.scale, s.scale, 1.0f);
            glRotatef(s.rotation, 0.0f, 0.0f, 1.0);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glPopMatrix(); 
            
            if(s.beingPlaced){
                glBindTexture(GL_TEXTURE_2D, texture);
                
            }
        }
    }
}


+(NSMutableArray*)getSatellites{
    return satellites;
}

-(void)removeNotification{
    [satellites removeObject:self];
    
}

- (void)touchesBeganX:(float)x andY:(float)y{
    NSLog(@"ff");
    if(beingPlaced){
        self.x = x;
        self.y = y;
        placementStarted = true;
    }else if(isUnderControl){
        float dist = sqrt((x-self.x)*(x-self.x) + (y-self.y)*(y-self.y));
        self.rotation =      180.0f * (atan2f((self.x  -x) / dist, (y-self.y)/ dist) / 3.14159  );
        [self fire];
    }else{
        [SBMenu setManualControlSelect:false];
        isUnderControl = true;
    }
    
}
- (void)touchesMovedX:(float)x andY:(float)y{
    if(beingPlaced && [[SpaceBase spaceBase] checkX:x checkY:y]  < 0 ){
        self.x = x;
        self.y = y;
    }
    if(isUnderControl){
        
    }
}
- (void)touchesEndedX:(float)x andY:(float)y{
    if(beingPlaced){
        moveObject = nil;
        beingPlaced = false;
		/*firstUpdate2
		bool firstupdate = [SBMenu firstUpdate2];
		bool s40;
		double t11 = CACurrentMediaTime() + 60;
		double t10 = CACurrentMediaTime();
		t11 = (t11 + 60); 
		if (firstupdate == false && s40 == false){
			double t12 = CACurrentMediaTime();
			s40 = true;
		}
		else if (firstupdate == true && s40 == true){
			double t13 = CACurrentMediaTime();
			s40 = false;
			t11 - t13
			double d == t13 - t12;
			endTime = d;
		} else {
			endTime = CACurrentMediaTime() + 60;
		}*/
		endTime = CACurrentMediaTime() + 60;
    }
    if(isUnderControl){
        moveObject = nil;
    }
	
}
- (void)touchesCancelledX:(float)x andY:(float)y{
    
}

-(void)fireAtTarget:(GameObject*)t{
    manualTarget = t; 
    [manualTarget retain];
    shouldFire = true;
}


+(void)fireAllAtTarget:(GameObject*)t{
    
    for(Satellite *s in satellites){
        [s fireAtTarget:t];
    }
    
}


-(void)update:(double)time{
    if(!beingPlaced){
        if(!isUnderControl){
            self.rotation += time* (targetRotation -self.rotation)/100.0;
            if(bullet!=nil){
                if(bullet.remove){
                    shouldFire = true;
                }else{
                    shouldFire = false;
                }
            }else{
                shouldFire = true;
            }
            if(manualTarget==nil){
                
                GameObject * target = nil;
            
                NSMutableArray *asteroids = [Asteroid getAsteroids];
				NSMutableArray *comets = [finalComet getComets];
                float closestDistance = 21100283;
                float computed = -1;
                for(Asteroid * a in asteroids){
                    computed = (a.y - self.y)*(a.y - self.y) + (a.x - self.x)*(a.x - self.x);
                    if(computed < closestDistance){
                        target = a;
                        closestDistance = computed;
                    }
                } 
				for(finalComet * n in comets){
                    computed = (n.y - self.y)*(n.y - self.y) + (n.x - self.x)*(n.x - self.x);
                    if(computed < closestDistance){
                        target = n;
                        closestDistance = computed;
                    }
                } 
                if(target !=nil){
                    float dist = sqrt((self.x  -target.x)*(self.x  -target.x) + (self.y  -target.y)* (self.y  -target.y));
                    float dx = (self.x  -target.x) / dist;
                    float dy = (self.y  -target.y) / dist;
                    targetRotation = (atan2f(dx, -dy)/(2*3.1415926535))*360;
                    if(self.rotation - targetRotation > 180){
                        targetRotation = self.rotation + (360-(self.rotation - targetRotation));
                    }
                    if(dist > 45){
                        shouldFire =  false;
                    }
                }
            }else{
                     float dist = sqrt((self.x  -manualTarget.x)*(self.x  -manualTarget.x) + (self.y  -manualTarget.y)* (self.y  -manualTarget.y));
                     self.rotation =      180.0f * (atan2f((self.x  -manualTarget.x) / dist, (manualTarget.y-self.y)/ dist) / 3.14159  );
                    [manualTarget release];
                    manualTarget = nil;
                if(bullet!=nil){
                    if(bullet.remove){
                        shouldFire = true;
                    }else{
                        shouldFire = false;
                    }
                }else{
                    shouldFire = true;
                }
            }
            if(shouldFire){
                if(bullet!=nil){
                    [bullet release];
                }
                bullet= [[SatelliteBullet alloc] initWithX:self.x andY:self.y andDx:sin(3.14159 +(self.rotation / 360.0)*2*3.1415926) andDy:cos((self.rotation / 360.0)*2*3.1415926)];
                [objects addObject: bullet];
                
                shouldFire = false;
            }
        }else{
            if(shouldFire){
                bullet= [[SatelliteBullet alloc] initWithX:self.x andY:self.y andDx:sin(3.14159 +(self.rotation / 360.0)*2*3.1415926) andDy:cos((self.rotation / 360.0)*2*3.1415926)];
                [objects addObject: bullet];
                [bullet release];
                shouldFire = false;
            }
            
        }
		double current  = CACurrentMediaTime();
        color = (endTime - current - 2) /10.0;
        if(current > endTime){
            for(Asteroid * a in targetObjects){
				NSLog(@"TEst3");
                if(!a.remove){
                    [Score changeCredits:10000];
                }
                a.remove = true;
            }
			for(finalComet * n in targetObjects){
				NSLog(@"TEST");
                if(!n.remove && [Score getAsteroidHealth] > 15.00){
                   // [Score changeCredits:10];
					[Score changeAsteroidHealth:-15];
                }
				if(!n.remove && [Score getAsteroidHealth] == 15.00){
					n.remove = true;
					self.remove=true;
				[Score changeCredits:750];
				}
            }
            self.remove = true;
			//	[SBMenu fccount]-1;
            [ParticleSystem registerExplosionX:self.x andY:self.y andType:2];
        }
        if(self.y > height - height*0.3){
            self.y +=  ((height) - self.y)/100.0;
            scale -=0.005;
        }
        if(scale < 0.1){
            self.remove = true;
            [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
        }
        
    }
}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@synthesize beingPlaced;
@synthesize placementStarted;
@synthesize scale;

@end
