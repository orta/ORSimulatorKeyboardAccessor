//
//  ORAppDelegate.m
//  KeyboardTest
//
//  Created by orta therox on 08/04/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORAppDelegate.h"
#import "ORViewController.h"

// The example is in ORViewController

@implementation ORAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ORViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
