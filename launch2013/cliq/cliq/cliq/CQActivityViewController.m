//
//  CQActivitiesViewController.m
//  activity
//
//  Created by Chenchen Zheng on 11/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQActivityViewController.h"
#import "CQFriendListViewController.h"

@interface CQActivityViewController ()
@property (nonatomic, strong) UIButton *actButton;
@property (nonatomic, strong) NSMutableArray *activities;
@property (nonatomic, strong) NSMutableArray *counts;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation CQActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    self.title = @"ACTIVITY";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController.navigationBar setBackgroundImage:[helper imageWithColor: [helper CQGreenColor]] forBarMetrics:UIBarMetricsDefault];
  [self getActFromParse];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [[NSUserDefaults standardUserDefaults] setObject:self.type forKey:@"ActivitiesType"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
	// Do any additional setup after loading the view.
  self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
  self.activities = [[NSMutableArray alloc] init];
  self.counts = [[NSMutableArray alloc] init];
  [self createView];
//  [self putDownFor2Parse];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkType
{
  NSLog(@"self.type is %@", self.type);
  if ([self.type isEqualToString:@"FREE"]) {
    NSLog(@"free");
    [self setBusyTheme];
  } else if ([self.type isEqualToString:@"BUSY"]) {
    NSLog(@"busy");
    [self setFreeTheme];
  }
}

- (void) createView
{
  self.actButton = [[UIButton alloc] initWithFrame:CGRectMake(142/2, 391/2, 355/2, 355/2)];
  [self.actButton addTarget:self action:@selector(checkType) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:self.actButton];
}

- (void) setFreeTheme
{
  //  UIColor *naviColor = [UIColor colorWithRed:24.0/256.0 green:176.0/256.0 blue:115.0/256.0 alpha:0.95];
  //  [[UINavigationBar appearance] setTintColor:naviColor];
  [self.actButton setBackgroundImage:[UIImage imageNamed:@"free"] forState:UIControlStateNormal];
//  [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:24.0/256.0 green:176.0/256.0 blue:115.0/256.0 alpha:1.0]];
  [self.navigationController.navigationBar setBackgroundImage:[helper imageWithColor: [helper CQGreenColor]] forBarMetrics:UIBarMetricsDefault];
  self.type = @"FREE";
  [self.view reloadInputViews];
  [self performSelector:@selector(frostPressed) withObject:nil afterDelay:0.5];
}

- (void) frostPressed
{
  NSArray *images = [self createImages];
  NSLog(@"images are %@", images);
  NSArray *sizes = [self createCounts];
  NSLog(@"sizes are %@", sizes);
  NSArray *borderColors = [self createBorderColors];
  NSLog(@"borderColors is %@", borderColors);
  
  RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:nil borderColors:borderColors];
  callout.itemSizes = sizes;
  callout.delegate = self;
  callout.showFromRight = YES;
  callout.width = self.view.bounds.size.width;
  callout.tintColor = [UIColor colorWithRed:241/256.0 green:242/256.0 blue:242/256.0 alpha:.7];
  callout.itemBackgroundColor = [helper CQGreenColor];
//  callout.itemBackgroundColor = [helper CQBackgroundColor];
  callout.itemSize = CGSizeMake(100, 100);
  [callout show];
}
- (void) setBusyTheme
{
  [self.actButton setBackgroundImage:[UIImage imageNamed:@"busy"] forState:UIControlStateNormal];
  UIColor *CQGrayColor = [UIColor colorWithRed:199/256.0 green:200/256.0 blue:202/256.0 alpha:1.0];
  [self.navigationController.navigationBar setBackgroundImage:[helper imageWithColor:CQGrayColor] forBarMetrics:UIBarMetricsDefault];
  [self.view reloadInputViews];
    self.type = @"BUSY";
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
  NSLog(@"Tapped item at index %lu",(unsigned long)index);
  NSLog(@"count is %lu", (unsigned long)[self.activities count]);
  if (index == ([self.activities count])) {
    [sidebar dismiss];
//    [self setBusyTheme];
  } else {
//    CQFriendListViewController *friendlist = [[CQFriendListViewController alloc] init];
//    friendlist.activity = [self.activities objectAtIndex:index-1];
//    [self.navigationController pushViewController:friendlist animated:YES];
  }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
  if (index == 0 || index == [self.counts count] + 2) {
    return;
  }
  if (itemEnabled) {
    [self.optionIndices addIndex:index];
  }
  else {
    [self.optionIndices removeIndex:index];
  }
}


#pragma mark - private methods
-(UIImage *)imageFromText:(NSString *)text
{
  // set the font type and size
  UIFont *font = [UIFont fontWithName:@"SACKERSGOTHICSTD-MEDIUM" size:14];
  CGSize size  = [text sizeWithFont:font];
  
  // check if UIGraphicsBeginImageContextWithOptions is available (iOS is 4.0+)
  if (UIGraphicsBeginImageContextWithOptions != NULL)
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
  else
    // iOS is < 4.0
    UIGraphicsBeginImageContext(size);
  
  // optional: add a shadow, to avoid clipping the shadow you should make the context size bigger
  //
  // CGContextRef ctx = UIGraphicsGetCurrentContext();
  // CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, 1.0), 5.0, [[UIColor grayColor] CGColor]);
  
  // draw in context, you can use also drawInRect:withFont:
  [text drawAtPoint:CGPointMake(0.0, 0.0) withFont:font];
  
  // transfer image
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

-(void) getActFromParse
{
  //what I want to do is get a list of activities with number of people with using it, so I create an nsdictionary with name and count, then create a nsarry with activities
  //  test Activities
  PFQuery *query = [PFQuery queryWithClassName:@"Activities"];
  [query orderByAscending:@"displayOrder"];
  [query addAscendingOrder:@"name"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
      // The find succeeded.
      NSLog(@"Successfully retrieved %lu activities. %@", (unsigned long)objects.count, objects);
      self.activities = [[NSMutableArray alloc] init];
      self.counts = [[NSMutableArray alloc] init];
      for (PFObject *object in objects) {
        NSLog(@"name is %@", [object objectForKey:@"name"]);
        NSLog(@"count is %@", [object objectForKey:@"count"]);
//        [self.activities setValue:[object objectForKey:@"count"] forKey:[object objectForKey:@"name"]];
        [self.activities addObject:[object objectForKey:@"name"]];
        [self.counts addObject:[object objectForKey:@"count"]];
      }
      NSLog(@"activities are %@", self.activities);
      [[NSUserDefaults standardUserDefaults] setObject:self.activities forKey:@"activity"];
      [[NSUserDefaults standardUserDefaults] setObject:self.counts forKey:@"activityCount"];
      self.type = [[NSUserDefaults standardUserDefaults] objectForKey:@"ActivitiesType"];
      if ([self.type isEqualToString:@"BUSY"]) {
        [self setBusyTheme];
        self.type = @"BUSY";
      } else {
        [self setFreeTheme];
      }
    } else {
      // Log details of the failure
      NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
  }];
}

- (NSArray *)createImages
{
  NSMutableArray *result = [[NSMutableArray alloc] init];
  for (int i = 0; i < [self.activities count]; i++) {
    [result addObject:[self imageFromText:[self.activities objectAtIndex:i]]];
  }
  [result addObject:[self imageFromText:@"done"]];
  NSLog(@"result is %@", result);
  return result;
}

- (NSArray *)createCounts
{
  NSLog(@"count is %@", self.counts);
  NSMutableArray *result = [[NSMutableArray alloc] init];
  for (int i = 0; i < [self.counts count]; i++) {
    if ([[self.counts objectAtIndex:i] floatValue] <= 30) {
      [result addObject:[NSNumber numberWithFloat:230/2]];
    } else
      [result addObject:[NSNumber numberWithFloat:315/2]];
  }
  [result addObject:[NSNumber numberWithFloat:60.0]];
  return result;
}
- (NSArray *)createBorderColors
{
  NSMutableArray *result = [[NSMutableArray alloc] init];
  for (int i = 0; i < [self.counts count]+1; i++) {
    [result addObject:[helper CQGreenColor]];
//    [result addObject:[UIColor grayColor]];
  }
  NSLog(@"border color is %@", result);
  return result;
}


- (void)putDownFor2Parse
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
