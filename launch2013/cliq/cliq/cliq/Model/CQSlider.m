//
//  CQSlider.m
//  cliq
//
//  Created by Chenchen Zheng on 11/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQSlider.h"

@implementation CQSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      NSMutableArray *numbers = [[NSMutableArray alloc] init];
      [numbers addObject:[NSNumber numberWithInt:0]];
      [numbers addObject:[NSNumber numberWithInt:1]];
      [numbers addObject:[NSNumber numberWithInt:2]];
      
      self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toggle"]];
      [self setTintColor:[UIColor clearColor]];
      [self setMinimumTrackTintColor:[UIColor clearColor]];
      [self setMaximumTrackTintColor:[UIColor clearColor]];
      [self setMinimumValue:0];
      [self setMaximumValue:((float)[numbers count] - 1)];
      self.value = 0;
      self.continuous = NO;
      [self addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];


    }
    return self;
}

- (void)valueChanged:(UISlider*)sender
{
  NSUInteger index = (NSUInteger)(self.value + 0.5); // Round the number.
  [self setValue:index animated:NO];
  NSLog(@"index: %lu", (unsigned long)index);
}

@end
