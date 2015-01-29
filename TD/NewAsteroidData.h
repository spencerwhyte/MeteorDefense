//
//  AsteroidData.h
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameWorld.h"
#import "Loader.h"

@interface NewAsteroidData : NSObject {
@private
    float data[108];
    bool shouldHighlight;
}
-(void)draw;
+(void)load;
@property bool shouldHighlight;
@end
