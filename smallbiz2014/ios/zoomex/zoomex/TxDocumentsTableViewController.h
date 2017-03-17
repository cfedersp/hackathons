//
//  TxDocumentsTableViewController.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/29/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ZoomRexAgent.h"
#import "ZoomRexTransaction.h"
#import "ZoomRexDocument.h"

@interface TxDocumentsTableViewController : UITableViewController {
    NSMutableArray *txDocuments;
    NSMutableArray *switchControls;
    NSArray *nib;
}

@property (strong, nonatomic) ZoomRexAgent* parentItem;
@property (strong, nonatomic) ZoomRexTransaction* detailItem;

@end
