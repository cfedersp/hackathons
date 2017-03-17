//
//  DocumentTableViewCell.h
//  zoomex
//
//  Created by Charlie Federspiel on 6/30/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexedUISwitch.h"
#import "ZoomRexDocument.h"

@interface DocumentTableViewCell : UITableViewCell {

    ZoomRexDocument* document;
}
@property (strong, nonatomic) ZoomRexDocument* document;
@property (nonatomic, weak) IBOutlet UISwitch* documentStatusSwitch;

-(IBAction) documentStatusChanged:(id)sender forEvent:(UIEvent *)event;
@end
