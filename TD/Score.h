//
//  Score.h
//  TD
//
//  Created by Spencer Whyte on 11-02-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


static float earthHealth;

static int credits;

static int score;
static float aasteroidHealth;

@interface Score : NSObject {
@private
    
}
+(void)reset;
+(void)load;
+(void)draw;
+(void)changeEarthHealth:(float)delta;
+(void)changeCredits:(int)delta;
+(float)getEarthHealth;
+(int)getCredits;
+(BOOL)hasLost;
+(int)getScore;
+(float)getAsteroidHealth;
+(void)changeAsteroidHealth:(float)delta;
@end
