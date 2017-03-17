//
//  DQViewController.h
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 22/01/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQManager.h"
#import "DQSecondViewController.h"
#import "DQObject.h"

@interface DQViewController : UIViewController <DQManagerDelegateProtocol, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *objectsTableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityWheel;
@property (nonatomic, strong) NSArray * objectsArray;
@property (nonatomic, weak) DQObject *selectedObject;
@property (nonatomic) DQSecondViewController* svc;
- (IBAction) startDiscovery:(id)sender;

- (IBAction) clearObjects:(id)sender;

@end
