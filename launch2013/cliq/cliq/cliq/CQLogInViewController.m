//
//  CQSplashViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQLogInViewController.h"
#import "CQProfileViewController.h"

@interface CQLogInViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation CQLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"LOGIN";
      UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"splash"]];
      self.view.backgroundColor = background;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  // Check if user is cached and linked to Facebook, if so, bypass login
  if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
    [self showHomeView];
  } else {
    [self createLogInButton];
  }
}

- (void) createLogInButton
{
  UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(25, 352, CGRectGetWidth(self.view.bounds) - 50, 33)];
  [login setImage:[UIImage imageNamed:@"splashbutton"] forState:UIControlStateNormal];
//  login.backgroundColor = [UIColor colorWithRed:59/256.0 green:89/256.0 blue:152/256.0 alpha:1.0];
  [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [login.titleLabel setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:18]];
  [login setTitle:@"login with facebook" forState:UIControlStateNormal];
//  login.titleLabel.textColor =[UIColor whiteColor];
  [login addTarget:self action:@selector(loginButtonTouchHandler:) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:login];
}

- (void)loginButtonTouchHandler:(id)sender  {
  // The permissions requested from the user
  NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"email", @"user_work_history", @"user_likes"];
  
  // Login PFUser using Facebook
  [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
    [self.activityIndicator stopAnimating]; // Hide loading indicator
    if (!user) {
      if (!error) {
        NSLog(@"Uh oh. The user cancelled the Facebook login.");
      } else {
        NSLog(@"Uh oh. An error occurred: %@", error);
      }
    } else if (user.isNew) {
      NSLog(@"User with facebook signed up and logged in!");
      [self showHomeView];
    } else {
      NSLog(@"User with facebook logged in!");
//      [self.navigationController pushViewController:[[CQProfileViewController alloc] init] animated:YES];
      [self showHomeView];
    }
  }];
  [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void)showHomeView
{
  CQProfileViewController *home = [[CQProfileViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:home];
  [self.navigationController presentViewController:navi animated:YES completion:^{
    NSLog(@"nothing");
  }];
}
@end
