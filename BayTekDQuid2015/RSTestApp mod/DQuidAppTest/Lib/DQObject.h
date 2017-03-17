//
//  DQObject.h
//  DQuidSdk
//
//  Created by Giorgio Scibilia on 17/03/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import "DQIncludes.h"

@class DQProperty;
@class DQData;


/**
 * This class represents a DQuid Object (any physical object tagged using the DQuid technology).
 * It shows all the needed object information and contains a dictionary of all the object properties.
 * 
 * The class also provides methods to (dis)connect and read/write the properties of the object.
 * 
 * It has a delegate object (that need to implement the 'DQObjectDelegateProtocol' protocol) that allows to handle events regarding this object.
 */
@interface DQObject : NSObject

#pragma mark - Public Mehtods

/// Delegate object (need to implement the 'DQObjectDelegateProtocol' protocol). It allows to handle events regarding this object
@property(nonatomic, weak)id<DQObjectDelegateProtocol>delegate;

/// Object name
- (NSString*) name;

/// Serial number of the attached DQuid Unit
- (NSString*) serialNumber;

/// A dictionary containing all the object properies (property names as keys, DQProperty objects as values).
- (NSMutableDictionary*) propertiesByName;

/// YES if the object is connected, NO otherwise
- (BOOL) connected;

/// The last time this object has been seen. This value is updated every time any data is exchanged with the object or it is detected through proximity technology (Ex. Bluetooth discovery)
- (NSDate*) lastSeen;

/// Object latitude when it was firstly configured
- (double) lat;

/// Object longitude when it was firstly configured
- (double) lon;

/// A dictionary containing object pictureId and backgroundColor (use as keys)
- (NSMutableDictionary*) pictureData;

/**
 * Tries to connect to the object
 * 
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 * 
 * @return BOOL YES if the request was successfully sent to the physical unit. NO otherwise (Ex. if object is already connected)
 */
- (BOOL) dqConnect;

/**
 * Tries to disconnect to the object
 *
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @return BOOL YES if the request was successfully sent to the physical unit. NO otherwise (Ex. if object is already connected)
 */
- (BOOL) dqDisconnect;

/**
 * Sends a read request for a certain property of the object
 *
 * The read value is sent back to the delegate object through the proper callback method.
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 * 
 * @param propertyName The name of the property whose value we are requesting
 * @param subscribe YES if you want to continuously receive updates about the property. NO if you just to want to read it once
 */
- (void) dqReadProperty:(NSString *)propertyName subscribe:(BOOL)subscribe;

/**
 * Sends an unsibscription request for a certain property of the object
 *
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param propertyName The name of the property whose value we are requesting
 */
- (void) dqUnsusbcribeFromProperty:(NSString *)propertyName;

/**
 * Sends a read request for a set of properties.
 *
 * All the values read are sent back to the delegate object through the proper callback method.
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param properties The (NSString) array containing the properties whose values we are requesting
 * @param subscribe YES if you want to continuously receive updates about those properties. NO if you just to want to read them once
 */
- (void) dqReadProperties:(NSArray*)properties subscribe:(BOOL)subscribe;

/**
 * Sends a (boolean) write request for a certain property of the object
 * It is recommended to check that the write data type of that prperty is DQ_BOOLEAN. If not, a proper transformation will be done.
 *
 * The read value is sent back to the delegate object through the proper callback method.
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param boolValue The value to be written
 * @param propertyName The name of the property whose value we are requesting
 */
- (void) dqWriteBool:(BOOL)boolValue toProperty:(NSString*)propertyName;

/**
 * Sends a (string) write request for a certain property of the object
 * It is recommended to check that the write data type of that prperty is DQ_STRING. If not, a proper transformation will be done.
 *
 * The read value is sent back to the delegate object through the proper callback method.
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param stringValue The value to be written
 * @param propertyName The name of the property whose value we are requesting
 */
- (void) dqWriteString:(NSString*)stringValue toProperty:(NSString*)propertyName;

/**
 * Sends a (raw data) write request for a certain property of the object
 * It is recommended to check that the write data type of that prperty is DQ_RAW. If not, a proper transformation will be done.
 *
 * The read value is sent back to the delegate object through the proper callback method.
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param rawValue The value to be written
 * @param propertyName The name of the property whose value we are requesting
 */
- (void) dqWriteRawData:(NSData*)rawValue toProperty:(NSString*)propertyName;

/**
 * Sends a (double) write request for a certain property of the object
 * It is recommended to check that the write data type of that prperty is DQ_NUMBER. If not, a proper transformation will be done.
 *
 * The read value is sent back to the delegate object through the proper callback method.
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param doubleValue The value to be written
 * @param propertyName The name of the property whose value we are requesting
 */
- (void) dqWriteNumber:(double)doubleValue toProperty:(NSString*)propertyName;

/**
 * Sends a write request (data type is automatically inferred) for a certain property of the object
 * This call will be forwarded to either 'dqWriteBool: toProperty:', 'dqWriteString: toProperty:', 'dqWriteRawData: toProperty:' or 'dqWriteNumber: toProperty:'.
 * Please use [NSNumber numberWithBool:] to write boolean values.
 *
 * 'onErrorOccurred' callback may be called subsequentially to any potential issue.
 *
 * @param value The value to be written
 * @param propertyName The name of the property whose value we are trying to write
 */
- (void) dqWrite:(id)value toProperty:(NSString*)propertyName;


/**
 * Used to check if two DQObjects instances refer to the same DQuid Object.
 * 
 * @param anOtherObject The DQObject to compare to the receiver
 * @return BOOL YES if the DQObject instance passed as parameter represents the same DQuid Object of the receiver
 */
- (BOOL) isEqualTo:(DQObject*)anOtherObject;

@end
