//
//  DQObjectServerData.m
//  DQuid
//
//  Created by luca minin on 16/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import "DQObjectServerData.h"

@implementation DQObjectServerData
@synthesize delegate = _delegate;
NSMutableData *_dataReceived;
long _statusCode;

NSString *const SERVER_URL_DATA = @"http://server-api.dquid.io/api/v1/";
// RSS our URL
//NSString *const SERVER_URL_DATA = @"http://staging.server-api.dquid.io/api/v1/";
NSString *const SERVER_POST_URL_DATA = @"data";
// RSS rest of the rest


+ (DQObjectServerData *)sharedController {
    static dispatch_once_t pred;
    static DQObjectServerData *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[DQObjectServerData alloc] init];
    });
    return shared;
}


+ (void) postNSDataToDQuidServer:(NSData*)bytesToSend propertyName:(NSString*)propertyName object:(DQObject*)object isRead:(BOOL)isRead delegate:(id<DQObjectSeverDataProtocol>)delegate{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DQObjectServerData *myRequest = [DQObjectServerData new];
        myRequest.delegate = delegate;
        [myRequest postDQObjectDataToDQuidServer:bytesToSend propertyName:propertyName object:object isRead:isRead];
//    });
}


+ (void) postByteToDQuidServer:(Byte)byteToSend propertyName:(NSString*)propertyName object:(DQObject*)object isRead:(BOOL)isRead delegate:(id<DQObjectSeverDataProtocol>)delegate{
    NSData *data = [NSData dataWithBytes:&byteToSend length:1];
    [DQObjectServerData postNSDataToDQuidServer:data propertyName:propertyName object:object isRead:isRead delegate:delegate];
}



/*Post data to DQuid server*/
- (int) postDQObjectDataToDQuidServer:(NSData*)bytesToSend propertyName:(NSString*)propertyName object:(DQObject*)object isRead:(BOOL)isRead {
    
    int error = 0;
    
    //Check that Nil objects are passed
    if (object==nil || object.serialNumber==nil || propertyName==nil) {
        return 1;
    }
    
    _dataReceived = [NSMutableData new];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVER_URL_DATA ,SERVER_POST_URL_DATA]]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    NSMutableString* string = [[NSMutableString alloc] init];
    
    [string appendString:@"["];
    [string appendString:@"{\n\t"];
    [string appendString:[NSString stringWithFormat:@" \"serialNumber\":\"%@\", \n\t", object.serialNumber]];  // DQ board Serial number
    [string appendString:[NSString stringWithFormat:@" \"objectName\":\"%@\", \n\t", object.name]]; // just DQ
    [string appendString:[NSString stringWithFormat:@" \"propertyName\":\"%@\", \n\t", propertyName]]; // 
    [string appendString:[NSString stringWithFormat:@" \"propertyValue\":\"%@\", \n\t", [DQObjectServerData getHexadecimalString:bytesToSend]]];
    [string appendString:@" \"propertyUM\":\" \", \n\t"];
    [string appendString:[NSString stringWithFormat:@" \"timestamp\":%llu, \n\t", (unsigned long long) ([[NSDate date] timeIntervalSince1970] * 1000)]];
    [string appendString:[NSString stringWithFormat:@" \"type\":\"%@\" \n\t", isRead==YES?@"read": @"write" ]];
    [string appendString:@"}"];
    [string appendString:@"]\n\t"];
    
    [body appendData:[string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    // setting the body of the post to the reqeust
    [postRequest setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [postRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    
    if(connection ==nil){
        return 1;
    }

    
    return error;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    ///NSLog(@"connection %@ didReceiveResponse %tu", [[connection.currentRequest URL]description], [((NSHTTPURLResponse *)response) statusCode]);
    
    _statusCode = [((NSHTTPURLResponse *)response) statusCode];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
   //NSLog(@"connection failed with error: %@",[error description]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    ///NSLog(@"connectionDidFinishLoading %@", [[connection.currentRequest URL]description]);
    
    NSString *resultString = [NSString new];
    
    if(_dataReceived !=nil && _dataReceived.length!=0) {
        resultString = [[NSString alloc] initWithData:_dataReceived encoding:NSUTF8StringEncoding];
    }
    
    switch (_statusCode) {
            
        case 200:
            if(_delegate!=nil)
                [_delegate onSendingDataSuccessful:[[[connection currentRequest] URL] description] statusCode:_statusCode response:resultString];
            break;
        case 201:
            if(_delegate!=nil)
                [_delegate onSendingDataSuccessful:[[[connection currentRequest] URL] description] statusCode:_statusCode response:resultString];
            break;
            
        default:
            if(_delegate!=nil)
                [_delegate onErrorWhileSendingData:[[[connection currentRequest] URL] description] statusCode:_statusCode response:resultString];
            break;
    }
    
    
    _dataReceived = [NSMutableData new];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
   // NSLog(@"connection %@ didReceiveData %@", [[connection.currentRequest URL]description], data);
    [_dataReceived appendData:data];
}



+ (NSString *)getHexadecimalString:(NSData*)data{
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [data length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    
    return [NSString stringWithString:hexString];
}

@end
