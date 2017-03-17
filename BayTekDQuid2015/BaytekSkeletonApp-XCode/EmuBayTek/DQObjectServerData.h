//
//  DQObjectServerData.h
//  DQuid
//
//  Created by luca minin on 16/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQData.h"
#import "DQProperty.h"
#import "DQObject.h"

@protocol DQObjectSeverDataProtocol <NSObject>

- (void) onSendingDataSuccessful:(NSString*)url statusCode:(long)statusCode response:(NSString*)response;
- (void) onErrorWhileSendingData:(NSString*)url statusCode:(long)statusCode response:(NSString*)response;

@end

@interface DQObjectServerData : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    
}

@property(nonatomic, weak)id<DQObjectSeverDataProtocol> delegate;
+ (void) postNSDataToDQuidServer:(NSData*)bytesToSend propertyName:(NSString*)propertyName object:(DQObject*)object isRead:(BOOL)isRead delegate:(id<DQObjectSeverDataProtocol>)delegate;
+ (void) postByteToDQuidServer:(Byte)byteToSend propertyName:(NSString*)propertyName object:(DQObject*)object isRead:(BOOL)isRead delegate:(id<DQObjectSeverDataProtocol>)delegate;

@end
