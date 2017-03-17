//
//  CQHomeViewController.m
//  test
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQHomeViewController.h"

@interface CQHomeViewController ()

@end

@implementation CQHomeViewController

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
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setBackgroundColor:[UIColor blackColor]];
  [button setFrame:CGRectMake(10, 10, 100, 100)];
  [button addTarget:self action:@selector(imageTouch:withEvent:) forControlEvents:UIControlEventTouchDown];
  [button addTarget:self action:@selector(imageMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
  [button setImage:[UIImage imageNamed:@"vehicle.png"] forState:UIControlStateNormal];
  [self.view addSubview:button];
	// Do any additional setup after loading the view.
}

- (IBAction) imageMoved:(id) sender withEvent:(UIEvent *) event
{
  UIControl *control = sender;
  
  UITouch *t = [[event allTouches] anyObject];
  CGPoint pPrev = [t previousLocationInView:control];
  CGPoint p = [t locationInView:control];
  
  CGPoint center = control.center;
  center.x += p.x - pPrev.x;
  center.y += p.y - pPrev.y;
  control.center = center;
}

- (IBAction) imageTouched:(id)sender withEvent:(UIEvent *) event
{
  
}
//- (IBAction) imageMoved:(id) sender withEvent:(UIEvent *) event
//{
//  CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
//  UIControl *control = sender;
//  control.center = point;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
