//
//  CQHomeViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQProfileViewController.h"
#import "CQAnalysisViewController.h"

@interface CQProfileViewController ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *email;
@property (nonatomic, strong) UILabel *location;
@property (nonatomic, strong) UILabel *occupation;
@property (strong, nonatomic) FBProfilePictureView *profilePictureView;

@end

@implementation CQProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"PROFILE";
      self.view.backgroundColor = [helper CQBackgroundColor];
//      [self setNavigationBar];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.view.backgroundColor = [UIColor colorWithRed:241/256.0 green:242/256.0 blue:242/256.0 alpha:1.0];
  [self setNavigationBar];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self createView];
  [self populateData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) populateData
{
  FBRequest *request = [FBRequest requestForMe];
  
  // Send request to Facebook
  [request startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
    if (!error) {
      // result is a dictionary with the user's Facebook data
//      NSDictionary *userData = (NSDictionary *)result;
      
//      NSMutableAttributedString *attributedString;
//      attributedString = [[NSMutableAttributedString alloc] initWithString:[user.name uppercaseString]];
//      [attributedString addAttribute:NSKernAttributeName value:@5 range:NSMakeRange(10, 5)];
//      [self.name setAttributedText:attributedString];
      
      
      [self.name setText: [user.name uppercaseString]];
      [self.email setText:[user objectForKey:@"email"]];
      [self.location setText:[[user objectForKey:@"location"] objectForKey:@"name"]];
      [self.occupation setText:[[[[user objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"] objectForKey:@"name"]];
      self.profilePictureView.profileID = user.id;
      
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      [defaults setObject:user.name forKey:@"myName"];
//      upload info to parse
      PFQuery *query = [PFUser query];
      PFUser *PU = [PFUser currentUser];
      [query whereKey:@"username" equalTo:PU.username];
      
      [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects are %@", objects);
        PFObject *Puser = [objects objectAtIndex:0];
        Puser[@"name"] = user.name;
        Puser[@"email"] = [user objectForKey:@"email"];
        Puser[@"location"] = [[user objectForKey:@"location"] objectForKey:@"name"];
        Puser[@"occupation"] = [[[[user objectForKey:@"work"] objectAtIndex:0] objectForKey:@"employer"] objectForKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:user.id forKey:@"myFBID"];
        [Puser saveInBackground];
      }];
      
      // Now add the data to the UI elements
      // ...
    } else {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:error.localizedDescription
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
      [alertView show];
    }
  }];
}

- (void) getUserInfo
{
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
      } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
      }
    }];
  }
}

- (void) createView
{
  // Initialize the profile picture
  self.profilePictureView = [[FBProfilePictureView alloc] init];
  // Set the size
  self.profilePictureView.frame = CGRectMake(0.0, 64, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
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
  
  [self.name setFont:[UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:16]];
  [self.email setFont:[UIFont fontWithName:@"Avenir-Roman" size:13]];
  [self.location setFont:[UIFont fontWithName:@"Avenir-Roman" size:13]];
  [self.occupation setFont:[UIFont fontWithName:@"Avenir-Roman" size:13]];
  [self.view addSubview:self.name];
  [self.view addSubview:self.email];
  [self.view addSubview:self.location];
  [self.view addSubview:self.occupation];
  
  UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
  [next setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
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


-(void) setNavigationBar
{
  [self.navigationController.navigationBar setBackgroundImage:[helper imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
}

- (void)uploadInfo2Parse
{
  PFQuery *query = [PFUser query];
  PFUser *user = [PFUser currentUser];
  [query whereKey:@"username" equalTo:user.username];
  
  NSArray *downFor = [[NSArray alloc] initWithObjects:@"Hiking", nil];
  //  NSArray *objects = [query findObjects];
  //  NSLog(@"objects is %@", objects);
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    PFObject *user = [objects objectAtIndex:0];
    user[@"downFor"] = downFor;
    [user saveInBackground];
  }];
}

@end
