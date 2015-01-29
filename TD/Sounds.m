//
//  Sounds.m
//  Space Base
//
//  Created by Mark Corbelli on 5/3/11.
//  Copyright 2011 Inysis. All rights reserved.
//

#import "Sounds.h"


@implementation Sounds
+(void)loadsounds{
	[Audio initAudio];
	[Audio loadAudioFile:@"Ambiento" forKey:@"Ambiento"];
	NSLog(@"Ambiento loaded");
	//[Audio loadAudioFile:<#(NSString *)fileName#> forKey:<#(NSString *)key#>
}
+(void)playsound:(NSString *)key{
//	[Audio playSound:key];
	//NSLog(@"Playing sound %@", key);
}
+(void)unloadSounds:(NSString *)key{
//	[Audio stopSound:key];
}
+(void)cleanup{
//[Audio cleanUpOpenAL];
}
@end
