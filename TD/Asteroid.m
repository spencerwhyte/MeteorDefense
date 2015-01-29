//
//  Asteroid.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Asteroid.h"


@implementation Asteroid

- (id)init {
    if ((self = [super init])) {
        data = [asteroidData objectAtIndex:rand()%[asteroidData count]];
        [asteroids addObject:self];
       rotationDifference = (rand()%100/50.0) -1;
		NSString *deviceType = [UIDevice currentDevice].model;
		
		if([deviceType isEqualToString:@"iPhone"])
		{
			speed = 1 +(rand()%10)/10.0;
			scale = 1.0;
		}
		if([deviceType isEqualToString:@"iPad"])
		{
			speed = 3 +(rand()%10)/10.0;
			scale = 2.0;
		}
        
        shouldHighlight =  false;
          inElectricField = false;
    }
    return self;
}




- (id)initWithX:(float)tempX andY:(float)tempY{
 
    if ((self =    [super initWithX:tempX andY:tempY])) {
        data = [asteroidData objectAtIndex:rand()%[asteroidData count]];
        [asteroids addObject:self];
        rotationDifference = (rand()%100/50.0) -1;
		speed3=1.0f;
		scale = 1.0;
        shouldHighlight =  false;
        inElectricField = false;
    }
    
    return self;
}

+(NSMutableArray *)getAsteroids{
    return asteroids;
}

-(void)removeNotification{
    [asteroids removeObject:self];
}

+(void)load{
    asteroids = [[NSMutableArray alloc] init];
    asteroidData = [[NSMutableArray alloc] init];
    texture = [Loader loadImageWithName:@"AsteroidTexture.png"];
    for(int i = 0 ; i < 100 ; i++){
        AsteroidData *a = [[AsteroidData alloc] init];
        [asteroidData addObject:a];
        [a release];

    }
}


+(void)reset{
    [asteroids release];
      asteroids = [[NSMutableArray alloc] init];
}


-(void)draw{
    glPushMatrix();
    glTranslatef(self.x, self.y,0);
    glRotatef(self.rotation, 0.0f, 0.0f, 1.0f);
    glScalef(scale, scale, 1.0);
    data.shouldHighlight = shouldHighlight;
    [data draw];
    glPopMatrix();
}

+(void)draw{
    glBindTexture(GL_TEXTURE_2D, texture);
    for(Asteroid * a in asteroids){
        [a draw];   
    }
    
}


-(void)update:(double)time{    
	//NSLog(@"Score: %i", [Score getScore]);
    self.rotation += rotationDifference;
	bool a1;
	bool a2;
	bool a3;
	bool a4;
	bool a5;
	bool a6;
	bool a7;
    if([Score getScore]<1000 && a1 == false){
		//NSLog(@"testome");
		//speed3+= (speed + 1);
		speed3 = (speed = 0.4 +(rand()%10)/10.0);
		a1=true;
	}
	if([Score getScore]<2000 && [Score getScore]>1000){	
		speed3 = (speed = 0.5 +(rand()%10)/10.0);
		a2=true;
	}	
	if([Score getScore]<3000 && [Score getScore]>2000){	
		//speed3+= (speed + 1);
		speed3 = (speed = 0.6 +(rand()%10)/10.0);
		a3=true;
	}	
	if([Score getScore]<4000 && [Score getScore]>3000){	
		speed3 = (speed = 0.7 +(rand()%10)/10.0);
		a4=true;
	}
	if([Score getScore]<5000 && [Score getScore]>4000){	
		speed3 = (speed = 0.8 +(rand()%10)/10.0);
		a5 = true;
	}
	if([Score getScore]<6000 && [Score getScore]>5000){	
		speed3 = (speed = 0.9 +(rand()%10)/10.0);
		//speed3+= (speed + 1);
		a6 = true;
	}
	if([Score getScore]<7000 && [Score getScore]>6000){	
		speed3 = (speed = 1.0 +(rand()%10)/10.0);
		//speed3+= (speed + 1);
		a7=true;
	}
	
	speed=speed3;
	//NSLog(@"speed2 %f",speed2);
	//NSLog(@"speed3 %f",speed3);
	//NSLog(@"Speed %f",speed);
    if(self.y > height - height*0.3){
        self.y +=  ((height) - self.y)/100.0;
        scale -=0.005;
    }else{
        if(self.mobile){
            self.y +=  (time/30.0)*speed;
        }
    }

	if(scale < 0.1){
        self.remove = true;
        [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
		if([Score getEarthHealth]>10.0){
			[Score changeEarthHealth:-10.0];
		}
    }
	
/*	if([Score getEarthHealth]<=10 && self.y < height* 0.1){
	//		self.remove = true;
		//	[ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
			if([Score getEarthHealth]<=10.0){
	//		[Score changeEarthHealth:-1.0];
			}	
	}	   
	if([Score getEarthHealth] < 20 && scale <10){
		self.remove = true;
        [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
    }*/
}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@synthesize  speed;
@synthesize  shouldHighlight;
@synthesize  inElectricField;
@end
