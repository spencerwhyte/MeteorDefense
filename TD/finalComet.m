//
//  Asteroid.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "finalComet.h"


@implementation finalComet

- (id)init {
    if ((self = [super init])) {
		if([Score getEarthHealth]<=10 && !finalComet1){
			finalComet1=true;
			data = [cometsData objectAtIndex:rand()%[cometsData count]];
			rotationDifference = (rand()%100/50.0) -1;
			[comets addObject:self];
			scale = 7.0;
			speed=1;
			//speed = 3 + (rand()%10)/10.0;
			//	i += 1;
			shouldHighlight =  false;
			inElectricField = false;
		}
    }
    return self;
}




- (id)initWithX:(float)tempX andY:(float)tempY{
	
    if ((self =    [super initWithX:tempX andY:tempY])) {
		if([Score getEarthHealth]<=10 && !finalComet1){
			finalComet1= true;
			data = [cometsData objectAtIndex:rand()%[cometsData count]];
			//rotationDifference = (rand()%100/50.0) -1;
			[comets addObject:self];
			scale2 = 8.0;
			scale=3.0;
			speed = 1.0;
			transx=width*0.15;
			w1=width*0.50;
			w2=width*0.30;
			w3=width*0.70;
			//i += 1;
			shouldHighlight =  false;
			inElectricField = false;
			scale3b=false;
		}
		
    }
    
    return self;
}

+(NSMutableArray *)getComets{
    return comets;
}

-(void)removeNotification{
    [comets removeObject:self];
}

+(void)load{
    comets = [[NSMutableArray alloc] init];
    cometsData = [[NSMutableArray alloc] init];
    texture = [Loader loadImageWithName:@"cometSprite.png"];
		for(int i = 0 ; i < 1 ; i++){
			CometData *a = [[CometData alloc] init];
			[cometsData addObject:a];
			[a release];
	}
	finalComet1 =false;
}


+(void)reset{
    [comets release];
	comets = [[NSMutableArray alloc] init];
    finalComet1 = false;
}


-(void)draw{
	glPushMatrix();
	glTranslatef(transx,self.y,0.0f);
    glRotatef(self.rotation, 0.0f, 0.0f, 1.0f);
    glScalef(scale3, scale3, 1.0);
    data.shouldHighlight = shouldHighlight;
    [data draw];
    glPopMatrix();
}

+(void)draw{
    glBindTexture(GL_TEXTURE_2D, texture);
    for(finalComet * a in comets){
        [a draw];   
    }
    
}


-(void)update:(double)time{    
	time2 = CACurrentMediaTime();
	time1 = CACurrentMediaTime();
    self.rotation += rotationDifference;
scale3+=(scale = 8)/125.0; 
	if(scale3 > 8.0){
	scale3=8.0;
	}
    if(self.y > height - height*0.1){
	//	time1=CACurrentMediaTime();
        self.y +=  ((height) - self.y)/125.0;
    }else{
        if(self.mobile){
			
            self.y +=  (time/30.0)*speed;
        }
	}
	
	if(self.y > height - height*0.6){
		[ParticleSystem registerExplosionX:width*0.50 andY:self.y+235.0 andType:0];
		[ParticleSystem registerExplosionX:width*0.30 andY:self.y+215.0 andType:0];
		[ParticleSystem registerExplosionX:width*0.70 andY:self.y+215.0 andType:0];
		//[ParticleSystem registerExplosionX:width*0.80 andY:self.y+215.0 andType:0];

	}
	if(self.y > height - height*0.2){
		//scale-=0.05;
	[Score changeEarthHealth:-10];
    }
		if([Score getEarthHealth] <=10){
			//[ParticleSystem registerExplosionX:width*0.50 andY:self.y+30.0 andType:0];
			
		}
}



- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}
@synthesize  speed;
@synthesize  shouldHighlight;
@synthesize  inElectricField;
@end
