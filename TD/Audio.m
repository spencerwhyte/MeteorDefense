//
//  Audio.m
//  Project Portara
//
//  Created by Spencer Whyte on 10-07-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Audio.h"


@implementation Audio
+(void)initAudio
{
	// Initialization
	mDevice = alcOpenDevice(NULL); // select the "preferred device"
	if (mDevice) {
		mContext=alcCreateContext(mDevice,NULL);// use the device to make a context
		alcMakeContextCurrent(mContext);		// set my context to the currently active one
	}
	bufferStorageArray = [[NSMutableArray alloc] init];
	soundDictionary = [[NSMutableDictionary alloc] init];
	
	
}


// open the audio file
// returns a big audio ID struct
+(void)loadAudioFile:(NSString*)fileName forKey:(NSString*)key
{
	
	
	AudioFileID ID;
	// use the NSURl instead of a cfurlref cuz it is easier
	NSURL * afUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@"caf"]];
	// do some platform specific stuff..
#if TARGET_OS_IPHONE
	OSStatus result2 = AudioFileOpenURL((CFURLRef)afUrl, kAudioFileReadPermission, 0, &ID);
#else
	OSStatus result2 = AudioFileOpenURL((CFURLRef)afUrl, fsRdPerm, 0, &ID);
#endif
	if (result2 != 0) NSLog(@"cannot openf file: %@",fileName);
	
	
	
	
	UInt64 outDataSize = 0;
	UInt32 thePropSize = sizeof(UInt64);
	OSStatus result = AudioFileGetProperty(ID, kAudioFilePropertyAudioDataByteCount, &thePropSize, &outDataSize);
	if(result != 0) NSLog(@"cannot find file size");
	UInt32 fileSize = (UInt32)outDataSize;
	
	
	// this is where the audio data will live for the moment
	unsigned char * outData = malloc(fileSize);
	
	// this where we actually get the bytes from the file and put them
	// into the data buffer
	OSStatus result3 = noErr;
	result = AudioFileReadBytes(ID, false, 0, &fileSize, outData);
	AudioFileClose(ID); //close the file
	
	if (result3 != 0) NSLog(@"cannot load effect: %@",fileName);
	
	NSUInteger bufferID;
	// grab a buffer ID from openAL
	alGenBuffers(1, &bufferID);
	
	// jam the audio data into the new buffer
	alBufferData(bufferID,AL_FORMAT_STEREO16,outData,fileSize,44100); 
	
	// save the buffer so I can release it later
	[bufferStorageArray addObject:[NSNumber numberWithUnsignedInteger:bufferID]];
	
	
	NSUInteger sourceID;
	
	// grab a source ID from openAL
	alGenSources(1, &sourceID); 
	
	// attach the buffer to the source
	alSourcei(sourceID, AL_BUFFER, bufferID);
	// set some basic source prefs
	alSourcef(sourceID, AL_PITCH, 1.0f);
	alSourcef(sourceID, AL_GAIN, 1.0f);
	if (true) alSourcei(sourceID, AL_LOOPING, AL_TRUE);
	
	// store this for future use
	[soundDictionary setObject:[NSNumber numberWithUnsignedInt:sourceID] forKey:key];	
	
	// clean up the buffer
	if (outData)
	{
		free(outData);
		outData = NULL;
	}
	
	
}

// the main method: grab the sound ID from the library
// and start the source playing
+ (void)playSound:(NSString*)soundKey
{
	NSNumber * numVal = [soundDictionary objectForKey:soundKey];
	if (numVal == nil) return;
	NSUInteger sourceID = [numVal unsignedIntValue];
	alSourcePlay(sourceID);
}
+(void)unloadAudio:(NSString*)key{
	int a = [soundDictionary indexOfAccessibilityElement:[soundDictionary objectForKey:key]];
	NSUInteger sourceID = [[soundDictionary objectForKey:key] unsignedIntegerValue];
	alDeleteSources(1, &sourceID);
	[soundDictionary removeObjectForKey:key];
	NSUInteger bufferID = [[bufferStorageArray objectAtIndex:a] unsignedIntegerValue];
	alDeleteBuffers(1, &bufferID);
	[bufferStorageArray removeObjectAtIndex:a];
	alcDestroyContext(mContext);
	// close the device
	alcCloseDevice(mDevice);
}

+ (void)stopSound:(NSString*)soundKey
{
	NSNumber * numVal = [soundDictionary objectForKey:soundKey];
	if (numVal == nil) return;
	NSUInteger sourceID = [numVal unsignedIntValue];
	alSourceStop(sourceID);
}

+(void)cleanUpOpenAL
{
	// delete the sources
	for (NSNumber * sourceNumber in [soundDictionary allValues]) {
		NSUInteger sourceID = [sourceNumber unsignedIntegerValue];
		alDeleteSources(1, &sourceID);
	}
	[soundDictionary removeAllObjects];
	
	// delete the buffers
	for (NSNumber * bufferNumber in bufferStorageArray) {
		NSUInteger bufferID = [bufferNumber unsignedIntegerValue];
		alDeleteBuffers(1, &bufferID);
	}
	[bufferStorageArray removeAllObjects];
	
	// destroy the context
	alcDestroyContext(mContext);
	// close the device
	alcCloseDevice(mDevice);
}


@end
