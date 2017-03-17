//
//  CQAnalysisViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQAnalysisViewController.h"
#import "CQActivityViewController.h"
#import "CQFriendListViewController.h"
#import "CQCliqsViewController.h"
#import "CQSettingsViewController.h"

@interface CQAnalysisViewController ()
@property (nonatomic, strong) CQSlider *deliberate;
@property (nonatomic, strong) CQSlider *spontaneous;
@property (nonatomic, strong) CQSlider *reserved;
@property (nonatomic, strong) CQSlider *focused;
@property (nonatomic, strong) CQSlider *calm;
@end

@implementation CQAnalysisViewController
@synthesize deliberate;
@synthesize spontaneous;
@synthesize reserved;
@synthesize focused;
@synthesize calm;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"PROFILE";
      self.view.backgroundColor = [helper CQBackgroundColor];
      [self createView];

    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self createAnalysisTool];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//  [self createView];
//  [self createAnalysisTool];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
//  UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 50)];
//  textView.text = @"I want to die";
//  textView.textColor = [UIColor blackColor];
//  [self.view addSubview:textView];
  
  UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  [next setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
  [next addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBarButton =  [[UIBarButtonItem alloc] initWithCustomView:next];
  [self.navigationItem setRightBarButtonItem:rightBarButton];
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//  [self.navigationItem.backBarButtonItem setImage:[UIImage imageNamed:@"backarrow"]];
  
}

-(void) nextPressed:(id)sender
{
  [self createTabBar];
}

- (void) createTabBar
{
  //  //  ccz: init Trabbar controller with height of 50, thinking not to display tab bar text
  CQActivityViewController *activity = [[CQActivityViewController alloc] init];
  UINavigationController *naviAct = [[UINavigationController alloc] initWithRootViewController:activity];
  [naviAct setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"activity"
                                                       image:[UIImage imageNamed:@"activityicon"]
                                               selectedImage:[UIImage imageNamed:@"activityselected"]]];
  
  
  CQFriendListViewController *friendList = [[CQFriendListViewController alloc] initWithNibName:@"CQFriendListViewController" bundle:nil];
  UINavigationController *naviFL = [[UINavigationController alloc] initWithRootViewController:friendList];
  [naviFL setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"people"
                                                      image:[UIImage imageNamed:@"peopleicon"]
                                              selectedImage:[UIImage imageNamed:@"peopleiconselected"]]];
  
  CQCliqsViewController *cliq = [[CQCliqsViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *naviCQ = [[UINavigationController alloc] initWithRootViewController:cliq];
  [naviCQ setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"cliqs"
                                                      image:[UIImage imageNamed:@"cliqsicon"]
                                                        tag:2]];
  
  CQSettingsViewController *settings = [[CQSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
  UINavigationController *naviSettings = [[UINavigationController alloc] initWithRootViewController:settings];
  [naviSettings setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"settings"
                                                            image:[UIImage imageNamed:@"settingsicon"]
                                                    selectedImage:[UIImage imageNamed:@"settingsselected"]]];
  NSArray *vcs = [NSArray arrayWithObjects:naviAct, naviFL, naviCQ, naviSettings, nil];
  UITabBarController *tabbar = [[UITabBarController alloc] init];
  [tabbar setViewControllers:vcs animated:YES];
  [self.navigationController presentViewController:tabbar animated:YES completion:^{
    NSLog(@"createTabBar");
  }];
}

- (void) createAnalysisTool
{
  NSLog(@"i'm here");
  //spacing is 37
  int y = 160;
  self.deliberate = [[CQSlider alloc] initWithFrame: CGRectMake(24, y, self.view.bounds.size.width - 48, 35)];
  self.spontaneous = [[CQSlider alloc] initWithFrame: CGRectMake(24,y+37+35, self.view.bounds.size.width - 48, 35)];
  self.reserved = [[CQSlider alloc] initWithFrame: CGRectMake(24,y+37+37+35*2, self.view.bounds.size.width - 48, 35)];
  self.focused = [[CQSlider alloc] initWithFrame: CGRectMake(24,y+37+37+37+35*3, self.view.bounds.size.width - 48, 35)];
  self.calm = [[CQSlider alloc] initWithFrame: CGRectMake(24,y+37+37+37+37+35*4, self.view.bounds.size.width - 48, 35)];
  [self.view addSubview: self.deliberate];
  [self.view addSubview: self.spontaneous];
  [self.view addSubview: self.reserved];
  [self.view addSubview: self.focused];
  [self.view addSubview: self.calm];
  
  UILabel *iam = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 35)];
  iam.textAlignment = NSTextAlignmentCenter;
  iam.font = [UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:16];
  iam.textColor = [UIColor blackColor];
  iam.text = @"I AM";
  
  UILabel *delib = [[UILabel alloc] initWithFrame:CGRectMake(37, 140, 100, 15)];
  UILabel *spont = [[UILabel alloc] initWithFrame:CGRectMake(37, 140+37+35, 100, 15)];
  UILabel *res = [[UILabel alloc] initWithFrame:CGRectMake(37, 140+37+37+35+35, 100, 15)];
  UILabel *foc = [[UILabel alloc] initWithFrame:CGRectMake(37, 140+37+37+37+35+35+35, 100, 15)];
  UILabel *cal = [[UILabel alloc] initWithFrame:CGRectMake(37, 140+37+37+37+37+35+35+35+35, 100, 15)];
  
  UILabel *inventive = [[UILabel alloc] initWithFrame:CGRectMake(37+self.view.bounds.size.width - 120, 140, 100, 15)];
  UILabel *planned = [[UILabel alloc] initWithFrame:CGRectMake(37+self.view.bounds.size.width - 120, 140+37+35, 100, 15)];
  UILabel *outgoing = [[UILabel alloc] initWithFrame:CGRectMake(37+self.view.bounds.size.width - 120, 140+37+37+35+35, 100, 15)];
  UILabel *social = [[UILabel alloc] initWithFrame:CGRectMake(37+self.view.bounds.size.width - 120, 140+37+37+37+35+35+35, 100, 15)];
  UILabel *excited = [[UILabel alloc] initWithFrame:CGRectMake(37+self.view.bounds.size.width - 120, 140+37+37+37+37+35+35+35+35, 100, 15)];

  
  delib.font = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  spont.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  res.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  foc.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  cal.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  
  inventive.font = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  planned.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  outgoing.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  social.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  excited.font  = [UIFont fontWithName:@"Avenir-Oblique" size:13];
  

  delib.textColor = [helper CQGreenColor];
  spont.textColor = [helper CQGreenColor];
  res.textColor = [helper CQGreenColor];
  foc.textColor = [helper CQGreenColor];
  cal.textColor = [helper CQGreenColor];
  
  inventive.textColor = [helper CQGreenColor];
  planned.textColor = [helper CQGreenColor];
  outgoing.textColor = [helper CQGreenColor];
  social.textColor = [helper CQGreenColor];
  excited.textColor = [helper CQGreenColor];

  delib.text = @"Deliberate";
  spont.text = @"Spontaneous";
  res.text = @"Reserved";
  foc.text = @"Focused";
  cal.text = @"Calm";
  inventive.text = @"Inventive";
  planned.text = @"Planned";
  outgoing.text = @"Outgoing";
  social.text = @"Social";
  excited.text = @"Excited";
  
//  Spontaneous Planned
//  Reserved Outgoing
//  Focused Social
//  Calm Excited
  [self.view addSubview:delib];
  [self.view addSubview:spont];
  [self.view addSubview:res];
  [self.view addSubview:foc];
  [self.view addSubview:cal];
  
  [self.view addSubview:inventive];
  [self.view addSubview:planned];
  [self.view addSubview:outgoing];
  [self.view addSubview:social];
  [self.view addSubview:excited];
  
  [self.view addSubview:iam];
}


@end
