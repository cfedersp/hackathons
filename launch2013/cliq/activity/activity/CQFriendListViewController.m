//
//  CQFriendListViewController.m
//  activity
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQFriendListViewController.h"

@interface CQFriendListViewController ()

@end

@implementation CQFriendListViewController

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
  self.arrRecords = [[NSMutableArray alloc] init];
  noOfSection = 3;
  for (int i = 0; i < 40; i++) {
    [self.arrRecords addObject:[[ alloc] initWithMale:arc4random() %2 isNotification:arc4random() %2]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
