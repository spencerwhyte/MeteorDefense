//
//  SatelliteBullet.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SatelliteBullet.h"


@implementation SatelliteBullet

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
    texture = [Loader loadImageWithName:@"SatelliteBeam.png"];
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
    for(SatelliteBullet* b  in bullets){
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
	NSMutableArray *newasteroids = [finalComet getComets];
    for(Asteroid *a in asteroids){
        if((a.x - self.x)*(a.x - self.x) + (a.y - self.y)*(a.y - self.y) < 300.0){
            if(!a.remove && !self.remove){
            [ParticleSystem registerExplosionX:a.x andY:a.y andType:2];
            [Score changeCredits:10000];
            a.remove = true;
            self.remove = true;
            }
        }
    }
	
	for(finalComet *n in comets){
        if((n.x - self.x)*(n.x - self.x) + (n.y - self.y)*(n.y - self.y) < 300.0){
            if(!n.remove && !self.remove && [Score getAsteroidHealth] > 15){
				[ParticleSystem registerExplosionX:n.x andY:n.y andType:2];
				[Score changeAsteroidHealth:-15];
				self.remove = true;
			}
			if(!n.remove && !self.remove && [Score getAsteroidHealth] == 15){
				[Score changeAsteroidHealth:-15];
				[ParticleSystem registerExplosionX:n.x andY:n.y andType:2];
				[Score changeCredits:750];
				self.remove = true;
            }
        }
    }
	
    
}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
