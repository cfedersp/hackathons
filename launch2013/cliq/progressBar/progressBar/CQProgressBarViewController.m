//
//  CQProgressBarViewController.m
//  progressBar
//
//  Created by Chenchen Zheng on 11/10/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQProgressBarViewController.h"

@interface CQProgressBarViewController ()

@property (nonatomic, strong) UISlider *slider;
@end

@implementation CQProgressBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  UIProgressView *p = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar ];
//  p.progressImage = [UIImage imageNamed:<#(NSString *)#>];
//  p.progress
  p.frame = CGRectMake(50, 100, CGRectGetWidth(self.view.bounds) - 100 , 33);
  [self.view addSubview:p];
  
  NSMutableArray *numbers = [[NSMutableArray alloc] init];
  [numbers addObject:[NSNumber numberWithInt:0]];
  [numbers addObject:[NSNumber numberWithInt:1]];
  [numbers addObject:[NSNumber numberWithInt:2]];
  
  self.slider = [[UISlider alloc] initWithFrame:CGRectMake(24, 200, CGRectGetWidth(self.view.bounds) - 48 , 35)];
  self.slider.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toggle"]];
  self.slider.tintColor = [UIColor clearColor];
//  [self.slider setThumbImage:[UIImage imageNamed:@"knob"] forState:UIControlStateNormal];
  [self.slider setMinimumTrackTintColor:[UIColor clearColor]];
  [self.slider setMaximumTrackTintColor:[UIColor clearColor]];
  [self.slider setMinimumValue:0];
  [self.slider setMaximumValue:((float)[numbers count] - 1)];
  self.slider.value = 0;
  self.slider.continuous = NO;
  // This makes the slider call the -valueChanged: method when the user interacts with it.
  [self.slider addTarget:self
             action:@selector(valueChanged:)
   forControlEvents:UIControlEventValueChanged];
  
  [self.view addSubview:self.slider];
}

- (void)valueChanged:(UISlider*)sender
{
  NSUInteger index = (NSUInteger)(self.slider.value + 0.5); // Round the number.
  [self.slider setValue:index animated:NO];
  NSLog(@"index: %lu", (unsigned long)index);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
