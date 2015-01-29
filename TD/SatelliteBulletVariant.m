//
//  SatelliteBulletVariant.m
//  TD
//
//  Created by Spencer Whyte on 11-02-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SatelliteBulletVariant.h"


@implementation SatelliteBulletVariant

- (id)init {
    if ((self = [super init])) {
        dx =0.0f;
        dy= 0.0f;
        [bullets addObject:self];
        self.rotation = atan2f(dx, dy);
    }
    
    return self;
}

- (id)initWithX:(float)tempX andY:(float)tempY andDx:(float)tempDx andDy:(float)tempDy{
    if ((self =    [super initWithX:tempX andY:tempY])) {
        dx = tempDx;
        dy= tempDy;
        [bullets addObject:self];
        self.rotation = 180 * (atan2f(-dx, dy) / 3.1415926535) ;
    }
    return self;
}


-(void)draw{
    glPushMatrix();
    glTranslatef(self.x, self.y,0);
    glRotatef(self.rotation, 0.0, 0.0f, 1.0f);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    glPopMatrix();
}
+(void)load{
    texture = [Loader loadImageWithName:@"rocketSprite.png"];
    bullets = [[NSMutableArray alloc] init];
}


+(void)reset{
    [bullets release];
    bullets = [[NSMutableArray alloc] init];
}

static const GLfloat sv2[] = {
    -10.0f, -10.0f,
    10.0f, -10.0f,
    -10.0f,  10.0f,
    10.0f,  10.0f
};




static  const GLfloat svt[] = {
    0.0f, 0.0f,
    1.0f, 0.0f,
    0.0f,  1.0f,
    1.0f,  1.0f,
};
+(void)draw{
    glBindTexture(GL_TEXTURE_2D, texture);
	glVertexPointer(2, GL_FLOAT, 0,sv2);
	glTexCoordPointer(2, GL_FLOAT,0 , svt);
    for(SatelliteBulletVariant* b  in bullets){
        [b draw];
    }
}

-(void)removeNotification{
    [bullets removeObject:self];   
}


-(void)update:(double)time{    
    self.x+=dx *time/5.0;
    self.y+=dy*time/5.0;
    if(self.x > width|| self.x < 0 || self.y > height || self.y < 0){
        self.remove = true;
    }
    NSMutableArray *asteroids = [Asteroid getAsteroids];
	NSMutableArray *comets = [finalComet getComets];
    for(Asteroid *a in asteroids){
        if((a.x - self.x)*(a.x - self.x) + (a.y - self.y)*(a.y - self.y) < 300.0){
            if(!a.remove && !self.remove){
                [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
                [Score changeCredits:10];
                a.remove = true;
                self.remove = true;
                
                for(Asteroid *a2 in asteroids){
                    
                    if((a2.x - self.x)*(a2.x - self.x) + (a2.y - self.y)*(a2.y - self.y) < 3000.0){
                        if(!a2.remove){
                            [ParticleSystem registerExplosionX:a2.x andY:a2.y andType:2];
                            [Score changeCredits:20];
                            a2.remove = true;
                        }
                    }
                    
                }
                
                break;
            }
        }
    }
	for(finalComet *c in comets){
        if((c.x - self.x)*(c.x - self.x) + (c.y - self.y)*(c.y - self.y) < 300.0){
            if(!c.remove && !self.remove){
				if([Score getAsteroidHealth] > 50){
					[ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
					[Score changeAsteroidHealth:-50];	
					self.remove = true;
				}
				if([Score getAsteroidHealth] == 50){
					[ParticleSystem registerExplosionX:self.x andY:self.y andType:2];
					[Score changeAsteroidHealth:-50];
					self.remove=true;
					[Score changeCredits:500];
				}
                break;
            }
        }
    }

    
}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end