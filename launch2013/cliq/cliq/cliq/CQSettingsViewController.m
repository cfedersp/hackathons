//
//  CQSettingsViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQSettingsViewController.h"
#import "CQAnalysisViewController.h"
#import "CQProfileViewController.h"

@interface CQSettingsViewController ()

@end

@implementation CQSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      self.title = @"SETTINGS";
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
  if (section == 0)
    return 2;
  else
    return 1;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      cell.textLabel.text = @"Profile";
    } if (indexPath.row == 1) {
      cell.textLabel.text = @"Analysis";
    }
  }
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      CQProfileViewController *profile = [[CQProfileViewController alloc] init];
      [self.navigationController pushViewController:profile animated:YES];
    }
    if (indexPath.row == 1) {
      CQAnalysisViewController *analysis = [[CQAnalysisViewController alloc] init];
      [self.navigationController pushViewController:analysis animated:YES];
    }
  }
}

@end
