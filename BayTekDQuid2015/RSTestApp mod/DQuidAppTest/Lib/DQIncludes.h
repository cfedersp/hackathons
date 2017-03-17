//
//  DQIncludes.h
//  DQuidSdk
//
//  Created by Giorgio Scibilia on 20/01/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

@class DQObject;
@class DQProperty;
@class DQData;

@import CoreBluetooth;
@import CoreLocation;


#pragma mark - Macros


/** 
 * This macro allow to access the main instance of DQManager. 
 * It is equivalent to write "[DQManager sharedController]"
 */
#define DQMANAGER   [DQManager sharedController]



#pragma mark - Protocols
/**
 * This protocol contains the methods needed to receive callbacks from a particular DQObject.
 * 
 * Every DQObject contains a delegate that has to implement this protocol.
 * Setting your class as delegate for a certain DQObject will result in receiving callbacks when an event (related to it) occurs.
 */
@protocol DQObjectDelegateProtocol <NSObject>

/**
 * Method called when a connection with the DQObject is successfully established
 */
- (void) onConnectionEstablished;

/**
 * Method called when a connection with the DQObject fails
 * 
 * A connection failure may cause a call to both this method and 'onErrorOccurred'
 */
- (void) onConnectionFailed;

/**
 * Method called as a consequence of a disconnection from the DQObject
 *
 * If the disconnection wasn't requested by the user, the method 'onErrorOccurred' will be likely invoked too.
 */
- (void) onDisconnection;

/**
 * Method called when any kind of error occurs.
 * 
 * This method is called if the error deals with the DQObject
 * 
 * 
 * @param error The error
 */
- (void) onErrorOccurred:(NSError*)error;

/**
 * Method called as soon as an updated value is available for a certain DQProperty of the DQObject.
 *
 * Please Note: If you subscribe to a certain property, this method will be called very frequently
 *
 * @param property The DQProperty that received the update
 * @param data The updated DQData
 */
- (void) onProperty:(DQProperty*)property receivedData:(DQData*)data;

@end







/**
 * This protocol contains the methods needed to handle any event related withthe Sdk.
 *
 * The DQManager main instance has a delegate that has to implement this protocol.
 * Setting your class as DQManager delegate will result in being notified of every error occurred, every new DQObject discovered, every (dis)connection success or failure, and every DQProperty of every DQObject receiving an update.
 */
@protocol DQManagerDelegateProtocol <NSObject>


/**
 * Method called every time a new DQObject has been discovered.
 * 
 * The method is not called if the discovered object is already contained in the known objects.
 * In this last case what happens is that the 'lastSeen' field of that DQObject is updated with the current date/time.
 * To have a list of the known objects you can call the 'dqKnownObjects' method of the DQManager.
 *
 * Note: Whenever this method is called, a notification with name "onNewObjectDiscovered" and userinfo @{object.name:object} will be posted
 *
 * @param object The DQObject just discovered.
 */
- (void) onNewObjectDiscovered:(DQObject*)object;

/**
 * Method called every time a connection to a DQObject has been correctly established.
 *
 * Note: Whenever this method is called, a notification with name "onConnectionEstablished" and userinfo @{object.name:object} will be posted
 *
 * @param object The connected DQObject.
 */
- (void) onConnectionEstablishedForObject:(DQObject*)object;

/**
 * Method called every time a connection to a DQObject fails.
 *
 * A connection failure may cause a call to both this method and 'onErrorOccurred'
 *
 * Note: Whenever this method is called, a notification with name "onConnectionFailed" and userinfo @{object.name:object} will be posted
 *
 * @param object The still disconnected DQObject.
 */
- (void) onConnectionFailedForObject:(DQObject*)object;

/**
 * Method called every time a disconnection to a DQObject happes.
 *
 * If the disconnection wasn't requested by the user, the method 'onErrorOccurred' will be likely invoked too.
 *
 * Note: Whenever this method is called, a notification with name "onDisconnection" and userinfo @{object.name:object} will be posted
 *
 * @param object The disconnected DQObject.
 */
- (void) onDisconnectionFromObject:(DQObject*)object;

/**
 * Method called when any kind of error is detected (during any operation done by the Sdk).
 *
 * Note: Whenever this method is called, a notification with name "onErrorOccurred" and userinfo @{error.code:error.localizdDescription} will be posted
 *
 * @param error The error
 */
- (void) onErrorOccurred:(NSError*)error;

/**
 * Method called as soon as an updated value is available for a certain DQProperty of any DQObject.
 *
 * Please Note: If you subscribe to a certain property, this method will be called very frequently
 *
 * Note: Whenever this method is called, a notification with name "onDQDataAvailable" and userinfo @{object.name:data} will be posted
 *
 * @param property The DQProperty that received the update
 * @param object The DQObject owning the DQProperty that received the update.
 * @param data The updated DQData
 */
- (void) onProperty:(DQProperty*)property ofObject:(DQObject*)object receivedData:(DQData*)data;

/**
 * Method called when a DQObject is detected through the iBeacon technology.
 * To have a complete description of the object perform a discovery.
 *
 * Note: Whenever this method is called, a notification with name "onDQObjectInRange" will be posted
 *
 */
- (void) onDQObjectInRange;


@end



#pragma mark - Typedefs

/**
 * This Enum lists all the available data types
 */
typedef NS_ENUM(int, dq_data_type){
    DQ_NUMBER = 0,
    DQ_STRING,
    DQ_BOOLEAN,
    DQ_RAW
};



