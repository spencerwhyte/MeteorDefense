//
//  Audio.h
//  Project Portara
//
//  Created by Spencer Whyte on 10-07-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/ExtendedAudioFile.h>


static ALCcontext* mContext;
static ALCdevice* mDevice;
static NSMutableArray *bufferStorageArray;
static NSMutableDictionary *soundDictionary;

@interface Audio : NSObject {
	
}


+(void)initAudio;
+(void)loadData;
+(void)loadAudioFile:(NSString*)fileName forKey:(NSString*)key;
+ (void)playSound:(NSString*)key;
+ (void)stopSound:(NSString*)soundKey;
+(void)cleanUpOpenAL;
+(void)unloadAudio:(NSString*)key;
@end
