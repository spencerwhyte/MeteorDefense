//
//  TDAppDelegate.m
//  TD
//
//  Created by Spencer Whyte on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TDAppDelegate.h"

#import "EAGLView.h"

#import "TDViewController.h"

@implementation TDAppDelegate


@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window.rootViewController = self.viewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
   
    [self.viewController stopAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Save data if appropriate.
    [self.viewController stopAnimation];
}

- (void)dealloc {

    [window release];
    [viewController release];
    [super dealloc];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self.viewController startAnimation];
}

@end
