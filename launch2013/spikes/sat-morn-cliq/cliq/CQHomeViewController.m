//
//  CQHomeViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQHomeViewController.h"
#import "CQAnalysisViewController.h"

@interface CQHomeViewController ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *email;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UILabel *occupation;
@property (strong, nonatomic) FBProfilePictureView *profilePictureView;

@end

@implementation CQHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"profile";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self createView];
  [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getData
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
                                      [self getUserInfo];
                                    }
                                  }];
    return;
  } else [self getUserInfo];
}
- (void) getUserInfo
{
  NSLog(@"i'm here");
  if (FBSession.activeSession.isOpen) {
    NSLog(@"is open!");
    // Override point for customization after application launch.
    [FBProfilePictureView class];
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
      if (!error) {
        NSLog(@"print result %@", user);
        //        i need likes, email, and phone number
        [self.name setText: user.name];
        [self.email setText:[user objectForKey:@"email"]];
        [self.location setText:[[user objectForKey:@"location"] objectForKey:@"name"]];
        [self.occupation setText:[[[[user objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"] objectForKey:@"name"]];
        self.profilePictureView.profileID = user.id;
        [self.view reloadInputViews];
        
      }
    }];
    //ccz: getting likes
//    [[FBRequest requestForGraphPath:@"me?fields=likes"] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//      NSLog(@"result is %@", result);
//    }];
  }
}

- (void) createView
{
  // Initialize the profile picture
  self.profilePictureView = [[FBProfilePictureView alloc] init];
  // Set the size
  self.profilePictureView.frame = CGRectMake(0.0, 60, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
  // Add the profile picture view to the main view
  [self.view addSubview:self.profilePictureView];
  
  self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetWidth(self.view.bounds) + 80, CGRectGetWidth(self.view.bounds) - 20, 20)];
  [self.name setTextAlignment:NSTextAlignmentCenter];
  self.email = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetWidth(self.view.bounds) + 100, CGRectGetWidth(self.view.bounds) - 20, 20)];
  [self.email setTextAlignment:NSTextAlignmentCenter];
  self.location = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetWidth(self.view.bounds) + 120, CGRectGetWidth(self.view.bounds) - 20, 20)];
  [self.location setTextAlignment:NSTextAlignmentCenter];
  self.occupation = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetWidth(self.view.bounds) + 140, CGRectGetWidth(self.view.bounds) - 20, 20)];
  [self.occupation setTextAlignment:NSTextAlignmentCenter];
  
  [self.name setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:14]];
  [self.email setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:14]];
  [self.location setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:14]];
  [self.occupation setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:14]];
  [self.view addSubview:self.name];
  [self.view addSubview:self.email];
  [self.view addSubview:self.location];
  [self.view addSubview:self.occupation];
  
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
  CQAnalysisViewController *analysis = [[CQAnalysisViewController alloc] init];
  [self.navigationController pushViewController:analysis animated:YES];
}


@end
