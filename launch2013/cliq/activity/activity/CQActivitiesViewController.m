//
//  CQActivitiesViewController.m
//  activity
//
//  Created by Chenchen Zheng on 11/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQActivitiesViewController.h"

@interface CQActivitiesViewController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) UIButton *actButton;
@property (nonatomic, strong) NSMutableDictionary *activities;
@end

@implementation CQActivitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.title = @"Activities";
	// Do any additional setup after loading the view.
  self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
  self.activities = [[NSMutableDictionary alloc] init];
  [self createView];
  [self getActFromParse];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  NSLog(@"type is %@", self.type == FREE ? @"FREE":@"BUSY");
  [self checkType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkType
{
  if (self.type == FREE) {
    NSLog(@"free");
    [self setBusyTheme];
  } else if (self.type == BUSY) {
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
  [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:24.0/256.0 green:176.0/256.0 blue:115.0/256.0 alpha:1.0]];
  self.type = FREE;
  [self.view reloadInputViews];
  [self performSelector:@selector(frostPressed) withObject:nil afterDelay:0.5];
}

- (void) frostPressed
{
  
  NSArray *images = @[
                      [UIImage imageNamed:@"gear"],
                      [self imageFromText:@"Movies"],
                      [self imageFromText:@"Happy Hours"],
                      [self imageFromText:@"Wine Tasting"],
                      ];
//  NSArray *images = [self createImages];
  
  NSArray *sizes = [[NSArray alloc] initWithObjects:
                    [NSNumber numberWithFloat: 60.0],
                    [NSNumber numberWithFloat: 230/2],
                    [NSNumber numberWithFloat: 315/2],
                    [NSNumber numberWithFloat: 230/2], nil];
//  NSMutableArray *images = [self createImages];
  RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
  callout.itemSizes = sizes;
  callout.delegate = self;
  callout.showFromRight = YES;
  callout.width = self.view.bounds.size.width;
  callout.tintColor = [UIColor colorWithRed:241/256.0 green:242/256.0 blue:242/256.0 alpha:.7];
  callout.itemBackgroundColor = [UIColor greenColor];
  callout.itemSize = CGSizeMake(100, 100);
  [callout show];
}
- (void) setBusyTheme
{
  [self.actButton setBackgroundImage:[UIImage imageNamed:@"busy"] forState:UIControlStateNormal];
  [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:199/256.0 green:200/256.0 blue:202/256.0 alpha:1.0]];
  self.type = BUSY;
  [self.view reloadInputViews];
//  self.navigationController.title

}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
  NSLog(@"Tapped item at index %lu",(unsigned long)index);
  if (index == 0) {
    [sidebar dismiss];
    [self setBusyTheme];
  }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
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
  UIFont *font = [UIFont systemFontOfSize:20.0];
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
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
      // The find succeeded.
      NSLog(@"Successfully retrieved %lu activities.", (unsigned long)objects.count);
      for (PFObject *object in objects) {
        [self.activities setObject:[object objectForKey:@"count"] forKey:[object objectForKey:@"name"]];
      }
      NSLog(@"activities are %@", self.activities);
    } else {
      // Log details of the failure
      NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
  }];
  return;
}

//- (NSArray *)createImages:(NSDictionary *)activities
//{
//}

@end
