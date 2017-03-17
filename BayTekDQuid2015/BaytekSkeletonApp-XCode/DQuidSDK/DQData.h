//
//  DQData+Setters.h
//  DQuidSdk
//
//  Created by Giorgio Scibilia on 21/01/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//


/**
 * Class representing the value of an object property at a certain time.
 *
 * It can be represented as BOOL, double, NSString or NSData
 */
@interface DQData : NSObject


#pragma mark - Public Methods

/// The DQProperty name
- (NSString *) name;

/// The DQProperty unit of measure
- (NSString *) unit;

/// The (UNIX) timestamp at which the value was received
- (unsigned long long) timestamp;

/// The value represented as double
- (double) doubleValue;

/// The value represented as NSString
- (NSString*) stringValue;

/// The value represented as BOOL
- (BOOL) boolValue;

/// The value represented as NSData
- (NSData*) rawValue;

/**
 * @return (NSString*) A human readable description of the DQData
 */
- (NSString*) description;

@end
