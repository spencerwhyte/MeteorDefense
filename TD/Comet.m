//
//  Asteroid.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Comet.h"


@implementation Comet

- (id)init {
    if ((self = [super init])) {
		if([Score getEarthHealth]<20){
			
			[comets addObject:self];
			scale = 1.0;
			speed = 2;
			shouldHighlight =  false;
			inElectricField = false;
		}
    }
    return self;
}




- (id)initWithX:(float)tempX andY:(float)tempY{
	
    if ((self =    [super initWithX:tempX andY:tempY])) {
      //  data = [cometsData objectAtIndex:rand()%[asteroidData count]];
        [comets addObject:self];
     //   rotationDifference = (rand()%100/50.0) -1;
		scale = 50;
		speed = 2;
        shouldHighlight =  false;
        inElectricField = false;
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
    texture = [Loader loadImageWithName:@"AsteroidTexture.png"];   
    for(int i = 0 ; i < 1 ; i++){
        Comet *a = [[cometsData alloc] init];
        [Comet addObject:a];
        [a release];
		
    }
	
}


+(void)reset{
    [comets release];
	comets = [[NSMutableArray alloc] init];
}


-(void)draw{
    glPushMatrix();
    glTranslatef(self.x, self.y,0);
    glRotatef(self.rotation, 0.0f, 0.0f, 1.0f);
    glScalef(50, 50, 1.0);
  // data.shouldHighlight = shouldHighlight;
   // [data draw];
    glPopMatrix();
}

+(void)draw{
    glBindTexture(GL_TEXTURE_2D, texture);
    for(Comet * a in comets){
        [a draw];   
    }
    
}


-(void)update:(double)time{    
	
    self.rotation += rotationDifference;
    
    if(self.y > height - height*0.3){
        self.y +=  ((height) - self.y)/100.0;
        scale -=0.005;
    }else{
        if(self.mobile){
            self.y +=  (time/30.0)*speed;
        }
    }
    if(scale < 1){
        self.remove = true;
        [ParticleSystem registerExplosionX:self.x andY:self.y andType:0];
        [Score changeEarthHealth:-10];
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
