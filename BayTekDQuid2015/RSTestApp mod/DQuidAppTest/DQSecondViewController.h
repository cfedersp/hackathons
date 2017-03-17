//
//  DQSecondViewController.h
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 23/04/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQObject.h"

@interface DQSecondViewController : UIViewController <DQObjectDelegateProtocol, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *propertiesTableView;
@property (nonatomic, weak) IBOutlet UILabel *objectNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *objectSerialLabel;
@property (nonatomic, strong) NSArray * properties;
@property (nonatomic, strong) DQObject *connectedObject;
@property (nonatomic, strong) NSMutableDictionary *cellsForProperties;

- (IBAction) readButtonPressed:(id)sender;
- (IBAction) subscribeSwitchTouched:(id)sender;
- (IBAction) writeSwitchTouched:(id)sender;
- (IBAction) writeButtonPressed:(id)sender;
- (IBAction) disconnect:(id)sender;

@end
