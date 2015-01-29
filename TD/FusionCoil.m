//

//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FusionCoil.h"

@implementation FusionCoil

- (id)init {
    if ((self = [super init])) {
        [fusionCoils addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        scale = 1.0;
        
        [Score changeCredits:-1*[FusionCoil getPrice]];  
        
        isUnderControl = false;
        hostLimit = 1;
		Limit = 1;
        targetObjects = [[NSMutableArray alloc] init];
            color = 1.0f;
    }
    
    return self;
}


- (id)initWithX:(float)tempX andY:(float)tempY{
    
    if ((self =    [super initWithX:tempX andY:tempY])) {
        [fusionCoils addObject:self];
        beingPlaced = false;
        placementStarted = false;
        moveObject = self;
        scale = 1.0;
      //  count+1;
		
        [Score changeCredits:-1*[FusionCoil getPrice]];  
        
        isUnderControl = false;
        hostLimit = 1;
        targetObjects = [[NSMutableArray alloc] init];
        color = 1.0f;
		Limit=1;
    }
    
    return self;
}



+(void)load{
    texture = [Loader loadImageWithName:@"fusionCoil.png"];
   texture2 = [Loader loadImageWithName:@"fusionCoil.png"];
    fusionCoils = [[NSMutableArray alloc] init ];
    price = 500;
}

+(void)reset{
    [fusionCoils release];
     fusionCoils = [[NSMutableArray alloc] init ];
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
    
    
    const GLfloat sv[] = {
        -width*0.06125, -  width*0.06125,
        width*0.06125, -  width*0.06125,
        -width*0.06125,   width*0.06125,
        width*0.06125,    width*0.06125
    };
    
    glBindTexture(GL_TEXTURE_2D, texture);
    glVertexPointer(2, GL_FLOAT, 0,sv);
    glTexCoordPointer(2, GL_FLOAT,0 , svt);
    for(int i = 0; i < [fusionCoils count] ; i++){
       FusionCoil *f  = [fusionCoils objectAtIndex:i];
        if(f.placementStarted){
            if(f.beingPlaced){
                glBindTexture(GL_TEXTURE_2D, texture2);
            }
            glPushMatrix();
            glTranslatef(f.x, f.y,0);
            glScalef(f.scale, f.scale, 1.0f);
            glRotatef(f.rotation, 0.0f, 0.0f, 1.0);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glPopMatrix(); 
            if(f.beingPlaced){
                glBindTexture(GL_TEXTURE_2D, texture);
            }
        }
    }
    
    
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    
    for(int i = 0; i < [fusionCoils count] ; i++){
        FusionCoil *f  = [fusionCoils objectAtIndex:i];
        if(f.placementStarted){
            glPushMatrix();
            glTranslatef(f.x + (width / 70.0), f.y - (height / 320.0),0);
            glScalef(f.scale /10.0, f.scale /8.0, 1.0f);
            glRotatef(f.rotation, 0.0f, 0.0f, 1.0);
            if(f.color > 0.0f){
                glColor4f(1-f.color, f.color, 0.0f, 1.0f);
            }else{
                if(((int)(-f.color *30)) %2 == 0){
                    glColor4f(0, 0, 0.0f, 1.0f);
                }else{
                  glColor4f(1, 0, 0.0f, 1.0f);
                }
            }
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glTranslatef(-20*(width / 70.0), 0.0,0.0);
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            glPopMatrix(); 
        }
    }
    
    glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
}


+(NSMutableArray*)getFusionCoils{
    return fusionCoils;
}

-(void)removeNotification{
    [fusionCoils removeObject:self];
	//[SBMenu fccount]-1;
    
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
        endTime = CACurrentMediaTime() + 8;
    }
    if(isUnderControl){
        
    }
}
- (void)touchesCancelledX:(float)x andY:(float)y{
    
}


-(void)update:(double)time{
    if(!beingPlaced){
        
        NSMutableArray *asteroids = [Asteroid getAsteroids];
        float computed = -1;
        for(Asteroid * a in asteroids){
            if(!a.inElectricField){
                computed = (a.y - self.y)*(a.y - self.y) + (a.x - self.x)*(a.x - self.x);
                if(computed < 9000){
                    if(![targetObjects containsObject:a]){
                        [targetObjects addObject:a];
                        a.mobile  = false;
                        a.inElectricField = true;
                        [ParticleSystem registerElectricityBetweenObject:self andObject:a withMaxDistance:300];
                    }
                }
            }
        }
        for(Asteroid * target in targetObjects){
            target.x += (self.x  - target.x) / 100.0;
            target.y += (self.y  - target.y) / 100.0;
        }
        if(self.y > height - height*0.3){
            self.y +=  ((height) - self.y)/100.0;
            scale -=0.005;
        }
        if(scale < 0.1){
            self.remove = true;
            [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
		//[SBMenu fccount]-1;
        }
        double current  = CACurrentMediaTime();
        color = (endTime - current - 2) /10.0;
        if(current > endTime){
            for(Asteroid * a in targetObjects){
                if(!a.remove){
                    [Score changeCredits:10];
                }
                a.remove = true;
            }
            self.remove = true;
		//	[SBMenu fccount]-1;
            [ParticleSystem registerExplosionX:self.x andY:self.y andType:2];
        }
        
    }
}


-(void)notifyElectricityRemoval{
    
    
}


- (void)dealloc {
    [targetObjects release];
    
    [super dealloc];
}
@synthesize beingPlaced;
@synthesize placementStarted;
@synthesize scale;
@synthesize color;

@end
