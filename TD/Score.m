//
//  Score.m
//  TD
//
//  Created by Spencer Whyte on 11-02-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Score.h"


@implementation Score

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

+(void)changeEarthHealth:(float)delta{
    earthHealth +=delta;
    if(delta < 0){
        score += delta;
    }
}

+(void)changeCredits:(int)delta{
    credits +=delta;
    if(delta > 0){
        score += delta;
    }
}
+(void) changeAsteroidHealth:(float)delta{
	aasteroidHealth +=delta;
}
+(void)reset{
    earthHealth=210.0f;
	aasteroidHealth=150;
    credits = 300;
    score = credits;
}

+(BOOL)hasLost{
    return (earthHealth < 0);
}

+(void)load{
    
    [Score reset];
}

+(void)draw{
    score = credits;
	NSLog(@"NAH: %f",aasteroidHealth);
	NSLog(@"%f",earthHealth);
  //  glPrint
//	glPrint( f, -2, 0, "Frames: %i",framesPerSecond);
    
}

+(float)getEarthHealth{
    return earthHealth;
    
}

+(int)getCredits{
    return credits;
    
}
+(float)getAsteroidHealth{
	return aasteroidHealth;	
}
+(int)getScore {
    return  score;
}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
