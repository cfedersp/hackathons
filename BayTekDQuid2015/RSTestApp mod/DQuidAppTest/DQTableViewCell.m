//
//  DQTableViewCell.m
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 22/04/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import "DQTableViewCell.h"

@implementation DQTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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

- (void)prepareForReuse {
    [super prepareForReuse];
}

@end
