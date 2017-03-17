//
//  DQAppDelegate.m
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 22/01/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import "DQAppDelegate.h"
#import "DQManager.h"

// #import <Parse/Parse.h>

@implementation DQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [DQMANAGER application:application didFinishLaunchingWithOptions:launchOptions];
    
   // [Parse setApplicationId:@"5RbTdwQeDO6bIy8ehOWgxSpCZI66nH3NEdgIKCdi" clientKey:@"VfTe2Y9bBLUNasVvLjMIAktYpatGfHtTVbN1KmPf"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [DQMANAGER applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [DQMANAGER applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [DQMANAGER applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [DQMANAGER applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [DQMANAGER applicationWillTerminate:application];
}

@end
