//
//  DQuidSdk.h
//  DQuidSdk
//
//  Created by Giorgio Scibilia on 20/01/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#include "DQIncludes.h"
#import <UIKit/UIKit.h>

@class DQData;
@class DQObject;
@class DQProperty;


/**
 * The DQManager gives access to the main features of the Sdk.
 * 
 * This class is intended to be used as a singleton.
 * You can use the macro DQMANAGER or the Class method "sharedController" in order to access its main instance.
 */
@interface DQManager : NSObject


/**
 * The delegate object will receive notifications about (dis)connected objects and incoming/outgoing data.
 */
@property(nonatomic, weak)id<DQManagerDelegateProtocol> delegate;


#pragma mark - Public Class Methods
/**
 * Class method used to access the unique instance of this singleton
 * @return (DQManager *) the main instance of DQManager
 */
+ (DQManager *)sharedController;



#pragma mark - Public Instance Methods


/**
 * Gives access to the Sdk version
 * 
 * @return (NSString*) The Sdk version
 */
- (NSString*) getSdkVersion;


/**
 * Enables the sdk logs
 */
- (void) enableLogs;


/**
 * Disables the sdk logs
 */
- (void) disableLogs;


/**
 * Starts the discovery of the user's DQuid Objects. Uses proximity connectivity (Only BLE supported, by now)
 */
- (void) dqDiscover;


/**
 * Stops the discovery of the user's DQuid Objects.
 */
- (void) dqStopDiscover;


/**
 * Returns the list of the objects known by now
 * @return (NSArray *) An array with the known objects (instances of the DQObject class)
 */
- (NSArray*) dqKnownObjects;


/**
 * Clears the list of the objects known by now
 */
- (void) dqClearKnownObjects;


/**
 * Updates the configurations of the objects known by now
 */
- (void) dqUppdateKnownObjectsConfigurations;


/**
 * To be used by the application in order to notify the DQuid Sdk about its lifecycle
 * @param application The calling application
 * @param launchOptions The launch options
 */
- (void) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


/**
 * To be used by the application in order to notify the DQuid Sdk about its lifecycle
 * @param application The calling application
 * @param launchOptions The launch options
 */
- (void) applicationWillResignActive:(UIApplication*)application;


/**
 * To be used by the application in order to notify the DQuid Sdk about its lifecycle
 * @param application The calling application
 */
- (void) applicationDidEnterBackground:(UIApplication*)application;


/**
 * To be used by the application in order to notify the DQuid Sdk about its lifecycle
 * @param application The calling application
 */
- (void) applicationWillEnterForeground:(UIApplication*)application;


/**
 * To be used by the application in order to notify the DQuid Sdk about its lifecycle
 * @param application The calling application
 */
- (void) applicationDidBecomeActive:(UIApplication*)application;


/**
 * To be used by the application in order to notify the DQuid Sdk about its lifecycle
 * @param application The calling application
 */
- (void) applicationWillTerminate:(UIApplication*)application;



@end
