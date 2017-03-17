//
//  ZoomRexDocument.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/29/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZoomRexDocumentRevision.h"

@interface ZoomRexDocument : NSObject {
    NSString* objectId;
    
    ZoomRexDocumentRevision* mostRecentRevision;
    ZoomRexDocumentRevision* allRevisions;
    
    NSString* status;
    NSString* shortName;
    NSString* description;
}

@property (strong, nonatomic) NSString* objectId;

@property (strong, nonatomic) NSString* status;
@property (strong, nonatomic) NSString* shortName;
@property (strong, nonatomic) NSString* description;

@property (strong, nonatomic) ZoomRexDocumentRevision* mostRecentRevision;
@property (strong, nonatomic) ZoomRexDocumentRevision* allRevisions;

@end
