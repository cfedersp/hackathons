//
//  DQProperty.h
//  DQuidSdk
//
//  Created by Giorgio Scibilia on 03/04/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import "DQIncludes.h"


/**
 * This class represents a property of a DQuid Object.
 * It contains the property name, unitof measure, and the information about readability/writeability.
 * It also shows which data type has to be used when reading/writing to it.
 */
@interface DQProperty : NSObject

#pragma mark - Properties

/// The Property Name
- (NSString*) name;

/// The Property Unit of Measure
- (NSString*) um;

/// The data type to be used when reading
- (dq_data_type) readDataType;

/// The data type to be used when writing
- (dq_data_type) writeDataType;

/// YES if the property is readable, NO otherwise
- (BOOL) isReadable;

/// YES if the property is writable, NO otherwise
- (BOOL) isWritable;

@end
