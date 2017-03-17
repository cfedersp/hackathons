//
//  DocumentTableViewCell.m
//  zoomex
//
//  Created by Charlie Federspiel on 6/30/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import "DocumentTableViewCell.h"

@implementation DocumentTableViewCell
@synthesize document;
@synthesize documentStatusSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (IBAction)documentStatusChanged:(IndexedUISwitch *)sender {
     NSLog(@"slider moved! %d", sender.offset);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
