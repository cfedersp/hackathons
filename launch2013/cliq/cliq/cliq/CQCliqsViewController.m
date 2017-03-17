//
//  CQCliqsViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQCliqsViewController.h"

@interface CQCliqsViewController ()

@end

@implementation CQCliqsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      self.title = @"CLIQS";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController.navigationBar setBackgroundImage:[helper imageWithColor: [helper CQGreenColor]] forBarMetrics:UIBarMetricsDefault];
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//  [self testQuery2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

//- (void)testQuery
//{
//  NSLog(@"testQUery");
//  // When your user logs in, immediately get and store its Facebook ID
//  [PFFacebookUtils logInWithPermissions:nil
//                                  block:^(PFUser *user, NSError *error) {
//                                    if (user) {
//                                      [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//                                        if (!error) {
//                                          // Store the current user's Facebook ID on the user
//                                          [[PFUser currentUser] setObject:[result objectForKey:@"id"]
//                                                                   forKey:@"fbId"];
//                                          [[PFUser currentUser] saveInBackground];
//                                          [self testQuery2];
//                                        }
//                                      }];
//                                    }
//                                  }];
//  
//  
//}
@end
