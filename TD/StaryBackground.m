//
//  StaryBackground.m
//  TD
//
//  Created by Spencer Whyte on 11-03-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaryBackground.h"


@implementation StaryBackground

- (id)init {
    if ((self = [super init])) {
        // Initialization code here.
    }
    
    return self;
}

+(void)loads{
    
    for(int i = 0; i < STARCOUNT; i++){
        positions [i*2] = rand()%((int)width); 
        positions[i*2+1] = (rand()%((int)height))*0.85;
        sizes[i] = (rand() % 100)/1000.0f;
        twinkleProgress [i] = (rand()%10000)/1000.0f;
    }
    
}

+(void)update:(double)time{
    for(int i = 0; i < STARCOUNT; i++){
        twinkleProgress [i] += time/5000.0;
        if(twinkleProgress[i] > 10){
            positions [i*2] = rand() %  ((int)width); 
            positions[i*2+1] = (rand() % ((int)height))*0.85;
            twinkleProgress[i] = 0;
        }
    }
}

+(void)draw{
    glColor4f(1.0, 1.0f, 1.0f, 1.0f);
    glDisable(GL_TEXTURE_2D);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(2, GL_FLOAT, 0, positions);
    for(int i = 0; i < STARCOUNT; i++){
        glPointSize(   (-twinkleProgress[i] * (twinkleProgress[i] - 10))*sizes[i]   );
        glDrawArrays(GL_POINTS, i, 1);
    }
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);

}

- (void)dealloc {
    // Clean-up code here.
    
    [super dealloc];
}

@end
