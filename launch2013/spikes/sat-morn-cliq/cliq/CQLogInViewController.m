//
//  CQSplashViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQLogInViewController.h"
#import "CQHomeViewController.h"

@interface CQLogInViewController ()

@end

@implementation CQLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Splash";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self createLogInButton];
}

- (void) createLogInButton
{
  UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.bounds) - 20, 50)];
  login.backgroundColor = [UIColor blackColor];
  login.titleLabel.text = @"test";
//  login.titleLabel.textColor =[UIColor whiteColor];
  [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:login];
}

- (void) login
{
  NSArray *perm = @[@"email", @"user_work_history", @"user_likes"];
  // FBSample logic
  // if the session is open, then load the data for our view controller
  if (!FBSession.activeSession.isOpen) {
    // if the session is closed, then we open it here, and establish a handler for state changes
    [FBSession openActiveSessionWithReadPermissions:perm
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState state,
                                                      NSError *error) {
                                    if (error) {
                                      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                          message:error.localizedDescription
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];
                                      [alertView show];
                                    } else if (session.isOpen) {
                                      NSLog(@"clip logged in");
//                                      [self getUserInfo];
                                      [self showHomeView];
                                    }
                                  }];
    return;
  }
}

- (void)showHomeView
{
  CQHomeViewController *home = [[CQHomeViewController alloc] init];
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:home];
  [self.navigationController presentViewController:navi animated:YES completion:^{
    NSLog(@"nothing");
  }];
}
@end
