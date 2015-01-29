//
//  SatelliteVariant.m
//  TD
//
//  Created by Spencer Whyte on 11-02-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "SatelliteVariant.h"


@implementation SatelliteVariant

- (id)init {
    if ((self = [super init])) {
        shouldFire =false;
        [satelliteVariants addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        bullet = nil;
        scale = 1.0;
        [Score changeCredits:-1*[SatelliteVariant getPrice]];  
        isUnderControl = false;
        loaded = true;
        manualTarget = nil;
        
        
    }
    
    return self;
}


- (id)initWithX:(float)tempX andY:(float)tempY{
    
    if ((self =    [super initWithX:tempX andY:tempY])) {
        shouldFire = false;
        [satelliteVariants addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        bullet = nil;
        scale = 1.0;
        [Score changeCredits:-1*[SatelliteVariant getPrice]];  
        isUnderControl = false;
        loaded = true;
        
        manualTarget = nil;
    }
    return self;
}

-(void)fire{
    shouldFire = true;
}

+(int)getPrice{
    return price;
}
+(void)load{
    texture = [Loader loadImageWithName:@"rocketLauncher.png"];
    texture2 = [Loader loadImageWithName:@"rocketLauncher.png"];
    satelliteVariants = [[NSMutableArray alloc] init ];
    price = 400.0;
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


+(void)reset{
    [satelliteVariants release];
    satelliteVariants = [[NSMutableArray alloc] init ];
}

static  const GLfloat svt[] = {
    0.0f, 0.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    1.0f,  1.0f,
};

+(void)draw{
const GLfloat sv[] = {
		-width*0.03125, -  width*0.06125,
		width*0.03125, -  width*0.06125,
		-width*0.03125,   width*0.06125,
		width*0.03125,    width*0.06125
	};
    glBindTexture(GL_TEXTURE_2D, texture);
    glVertexPointer(2, GL_FLOAT, 0,sv);
    glTexCoordPointer(2, GL_FLOAT,0 , svt);
    for(int i = 0; i < [satelliteVariants count] ; i++){
        
        SatelliteVariant *s  = [satelliteVariants objectAtIndex:i];
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
    
    
    
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    
    for(int i = 0; i < [satelliteVariants count] ; i++){
        SatelliteVariant *s  = [satelliteVariants objectAtIndex:i];
        if(s.placementStarted){
            glPushMatrix();
            glTranslatef(s.x, s.y ,0);
            glRotatef(s.rotation, 0.0f, 0.0f, 1.0);
            glTranslatef(0.0,  -1* (height / 50.0),0);
            glScalef(s.scale /5.0, s.scale /5.0, 1.0f);
            if(s.loaded){
                glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
            }else{
                glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
            }
            
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glTranslatef(width/20.0, 0.0f, 0.0f);
            glScalef(0.5f, 0.5f, 0.5f);
            
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glTranslatef(-4*(width/20.0), 0.0f, 0.0f);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glPopMatrix(); 
        }
    }
    
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}


+(NSMutableArray*)getSatelliteVariants{
    return satelliteVariants;
}

-(void)removeNotification{
    [satelliteVariants removeObject:self];
    
}

- (void)touchesBeganX:(float)x andY:(float)y{
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
    if(beingPlaced && [[SpaceBase spaceBase] checkX:x checkY:y] < 0 ){
        
        self.x = x;
        self.y = y;
    }
}
- (void)touchesEndedX:(float)x andY:(float)y{
    if(beingPlaced){
        moveObject = nil;
        beingPlaced = false;
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
}
+(void)fireAllAtTarget:(GameObject*)t{
    for(SatelliteVariant * s in satelliteVariants){
        [s fireAtTarget:t];
    }
}

-(void)update:(double)time{
    if(!beingPlaced){
        if(!isUnderControl){
			if(![SBMenu manualControlSelect]){
            self.rotation += time* (targetRotation -self.rotation)/100.0;
			}
            if(bullet!=nil){
                if(bullet.remove){
                    shouldFire = true;
                }
            }else{
                shouldFire = true;
            }
            if(!loaded){
                shouldFire=false;
                if(CACurrentMediaTime() > reloadTime){
                    loaded=true;
                }
                
            }
            
            if(manualTarget == nil){
                
                GameObject * target = nil;
			//	NewAsteroids * newasteroids = nil;
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
				for(finalComet * c in comets){
                    computed = (c.y - self.y)*(c.y - self.y) + (c.x - self.x)*(c.x - self.x);
                    if(computed < closestDistance){
                        target = c;
                        closestDistance = computed;
                    }
                }
					if(target !=nil){
                    float dist = sqrt((self.x  -target.x)*(self.x  -target.x) + (self.y  -target.y)* (self.y  -target.y));
                    if(dist > 80){
                        shouldFire =  false;
                    }
                    float dx = (self.x  -target.x) / dist;
                    float dy = (self.y  -target.y) / dist;
                    targetRotation = (atan2f(dx, -dy)/(2*3.1415926535))*360;
                    if(self.rotation - targetRotation > 180){
                        targetRotation = self.rotation + (360-(self.rotation - targetRotation));
                    }
                }else{
                    shouldFire = false;
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
                bullet= [[SatelliteBulletVariant alloc] initWithX:self.x andY:self.y andDx:sin(3.14159 +(self.rotation / 360.0)*2*3.1415926) andDy:cos((self.rotation / 360.0)*2*3.1415926)];
                [objects addObject: bullet];
                shouldFire = false;
                
                loaded = false;
                reloadTime = CACurrentMediaTime() +1;
                
            }
        }else{
            if(shouldFire){
                bullet= [[SatelliteBulletVariant alloc] initWithX:self.x andY:self.y andDx:sin(3.14159 +(self.rotation / 360.0)*2*3.1415926) andDy:cos((self.rotation / 360.0)*2*3.1415926)];
                [objects addObject: bullet];
                [bullet release];
                shouldFire = false;
            }
            
        }
        if(self.y > height - height*0.3){
            self.y +=  ((height) - self.y)/100.0;
            scale -=0.005;
        }
		double current  = CACurrentMediaTime();
        color = (endTime - current - 2) /10.0;
        if(current > endTime){
            self.remove = true;
			//	[SBMenu fccount]-1;
            [ParticleSystem registerExplosionX:self.x andY:self.y andType:2];
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
@synthesize  loaded;
@end
