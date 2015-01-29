//
//  Sounds.h
//  Space Base
//
//  Created by Mark Corbelli on 5/3/11.
//  Copyright 2011 Inysis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Audio.h"

@interface Sounds : NSObject {

}
+(void)loadsounds;
+(void)playsound:(NSString*)key;
+(void)unloadSounds:(NSString*)key;
+(void)cleanup;
@end
