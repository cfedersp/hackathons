//
//  CQAnalysisViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQAnalysisViewController.h"
#import "CQActivitiesViewController.h"

@interface CQAnalysisViewController ()

@end

@implementation CQAnalysisViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"analysis";
      self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	// Do any additional setup after loading the view.
  [self createView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
  UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 50)];
  textView.text = @"I want to die";
  textView.textColor = [UIColor blackColor];
  [self.view addSubview:textView];
  
  
  UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  [next setBackgroundColor:[UIColor whiteColor]];
  [next setBackgroundImage:[UIImage imageNamed:@"setting_icon"] forState:UIControlStateNormal];
  [next addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarButton =  [[UIBarButtonItem alloc] initWithCustomView:next];
  [self.navigationItem setRightBarButtonItem:rightBarButton];
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  
}

-(void) nextPressed:(id)sender
{
  CQActivitiesViewController *activities = [[CQActivitiesViewController alloc] init];
  [self.navigationController pushViewController:activities animated:YES];
}

@end
