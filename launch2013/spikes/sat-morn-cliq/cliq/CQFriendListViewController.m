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
  [self getFriendList];
	// Do any additional setup after loading the view.
  self.arrRecords = [[NSMutableArray alloc] init];
//  noOfSection = 3;
//  for (int i = 0; i < 40; i++) {
//    [self.arrRecords addObject:[[ alloc] initWithMale:arc4random() %2 isNotification:arc4random() %2]];
//}
  
}

- (void) getFriendList
{
  FBRequest* friendsRequest = [FBRequest requestForMyFriends];
  [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                NSDictionary* result,
                                                NSError *error) {
    NSArray* friends = [result objectForKey:@"data"];
    NSLog(@"Found: %lu friends", (unsigned long)friends.count);
    for (NSDictionary<FBGraphUser>* friend in friends) {
      NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
    }
  }];
}

@end
