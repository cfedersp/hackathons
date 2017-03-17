//
//  DQTableViewCell.h
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 22/04/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQSwitch.h"
#import "DQButton.h"

@interface DQTableViewCell : UITableViewCell

@property(nonatomic)IBOutlet DQSwitch *writeSwitch;
@property(nonatomic)IBOutlet DQSwitch *subscribeSwitch;
@property(nonatomic)IBOutlet UILabel *readLabel;
@property(nonatomic)IBOutlet UITextField *writeTextField;
@property(nonatomic)IBOutlet UILabel *propertyNameLabel;
@property(nonatomic)IBOutlet DQButton *readButton;
@property(nonatomic)IBOutlet DQButton *writeButton;

@end
