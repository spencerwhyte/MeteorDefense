//

//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ElectricFence.h"

@implementation ElectricFence

- (id)init {
    if ((self = [super init])) {
        [electricFences addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        scale = 1.0;
        
        [Score changeCredits:-1*[ElectricFence getPrice]];  
        
        isUnderControl = false;
        hostLimit = 1;
		targetObjects = [[NSMutableArray alloc] init];
		color = 1.0f;
    }
    
    return self;
}


- (id)initWithX:(float)tempX andY:(float)tempY{
    
    if ((self =    [super initWithX:tempX andY:tempY])) {
        [electricFences addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        scale = 1.0;
        [Score changeCredits:-1*[ElectricFence getPrice]];  
        isUnderControl = false;
        hostLimit = 1;
        
    }
    
    return self;
}



+(void)load{
    texture = [Loader loadImageWithName:@"electricFence.png"];
    texture2 = [Loader loadImageWithName:@"electricFence2.png"];
    electricFences = [[NSMutableArray alloc] init ];
    price = 1000;
    electricData[0] = 0;
    electricData[1] = 0;
    for(int i = 2 ; i < ELECTRICCOUNT; i+=2){
            electricData[i] = i;
            electricData[i+1] = electricData[i-2] + -0.5 + ((rand()%100)/100.0);
    }
    
}

+(void)reset{
    [electricFences release];
    electricFences = [[NSMutableArray alloc] init ];
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
    if(isUnderControl && ![[SpaceBase spaceBase] checkX:x1 checkY:y1]){
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
    
    
    for(int i = 2 ; i < ELECTRICCOUNT - 30; i+=2){
        electricData[i] = i;
        electricData[i+1] = electricData[i-1] + -2 + ((rand()%100)/25.0);
    }
    for(int i = ELECTRICCOUNT - 30 ; i < ELECTRICCOUNT; i+=2){
        electricData[i] = i;
        if(electricData[i-1]  < 0){
              electricData[i+1] =  electricData[i-1] +1;
        }else{
            electricData[i+1] =  electricData[i-1] - 1;
        }
     
    }
    const GLfloat sv[] = {
        -width*0.06125, -  width*0.06125,
        width*0.06125, -  width*0.06125,
        -width*0.06125,   width*0.06125,
        width*0.06125,    width*0.06125
    };
    
    
    for(int i = 0; i < [electricFences count] ; i++){
        
        ElectricFence *e  = [electricFences objectAtIndex:i];
        if(e.placementStarted){
            if(e.beingPlaced){
                glBindTexture(GL_TEXTURE_2D, texture);
                
            }
            
            
            glPushMatrix();
            glDisable(GL_TEXTURE_2D);
            glColor4f(0.6,0.6f, 1.0f, 1.0f);
            glPointSize(2.0);
            glDisableClientState(GL_TEXTURE_COORD_ARRAY);
            glTranslatef(0, e.y, 0.0);
            glVertexPointer(2, GL_FLOAT, 0, electricData);
            glDrawArrays(GL_POINTS, 0, ELECTRICCOUNT);
            
            glEnable(GL_TEXTURE_2D);
            glEnableClientState(GL_TEXTURE_COORD_ARRAY);
            glColor4f(1.0, 1.0f, 1.0f, 1.0f);
            glPopMatrix();
            
    
            glPushMatrix();
			glBindTexture(GL_TEXTURE_2D, texture);
			glVertexPointer(2, GL_FLOAT, 0,sv);
			glTexCoordPointer(2, GL_FLOAT,0 , svt);
            glTranslatef(17.0f, e.y,0);
            glScalef(e.scale, e.scale, 1.0f);
            glRotatef(e.rotation, 0.0f, 0.0f, 1.0);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glPopMatrix(); 
            
            
            
			
            glPushMatrix();
			glBindTexture(GL_TEXTURE_2D, texture2);
			glVertexPointer(2, GL_FLOAT, 0,sv);
			glTexCoordPointer(2, GL_FLOAT,0 , svt);
            glTranslatef(width-17.0f, e.y,0);
            glScalef(e.scale, e.scale, 1.0f);
            glRotatef(e.rotation, 0.0f, 0.0f, 1.0);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glPopMatrix(); 
            
            
            if(e.beingPlaced){
                glBindTexture(GL_TEXTURE_2D, texture2);
                
            }
        }
    }
}


+(NSMutableArray*)getElectricFences{
    return electricFences;
}

-(void)removeNotification{
    [electricFences removeObject:self];
    
}

- (void)touchesBeganX:(float)x andY:(float)y{
    if(beingPlaced){
        self.x = x;
        self.y = y;
        placementStarted = true;
    }
    if(isUnderControl){
        
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
		endTime = CACurrentMediaTime() + 20;
    }
    if(isUnderControl){
        
    }
}


- (void)touchesCancelledX:(float)x andY:(float)y{
    
}


-(void)update:(double)time{
    if(!beingPlaced){
		
		NSMutableArray *asteroids = [Asteroid getAsteroids];

        for(Asteroid * a in asteroids){
			if((a.x < width || a.x > 0.0f) && a.y > self.y-5){
				if(![targetObjects containsObject:a]){
					[targetObjects addObject:a];
                    a.shouldHighlight = YES;
					a.mobile  = false;
				}
            }
        }
        for(Asteroid * target in targetObjects){
			if(target.x >= width-17.0f){
			target.x -= (width-17.0f) / 100.0;
			}
			if(target.x <= 17.0f){
				target.x += (17.0f) / 100.0;
			}
            target.y += (self.y  - target.y) / 100.0;
        }
            
        if(self.y > height - height*0.3){
            self.y +=  ((height) - self.y)/100.0;
            scale -=0.005;
        }
        if(scale < 0.1){
            self.remove = true;
            [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
        }
		double current  = CACurrentMediaTime();
        color = (endTime - current - 2) /10.0;
        if(current > endTime){
            for(Asteroid * a in targetObjects){
                a.shouldHighlight =NO;
				a.mobile = true;

            }
            self.remove = true;
            [ParticleSystem registerExplosionX:20 andY:self.y andType:2];
            [ParticleSystem registerExplosionX:width-20 andY:self.y andType:2];
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
@synthesize color;
@end
