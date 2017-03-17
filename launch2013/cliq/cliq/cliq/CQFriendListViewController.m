//
//  CQFriendListViewController.m
//  activity
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQFriendListViewController.h"
#import "UIView+Positioning.h"

#define selectedTag 100
#define cellSize 93
#define textLabelHeight 20
#define cellAAcitve 1.0
#define cellADeactive 0.3
#define cellAHidden 0.0
#define defaultFontSize 10.0

#define numOfimg 20

@interface CQFriendListViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>
{
  NSIndexPath *lastAccessed;
}

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UILabel *headerLabel;
//@property (nonatomic, strong) NSArray *friendList;

@property (nonatomic, strong) NSArray *activity;
@property (nonatomic) int selected;


@property (nonatomic, strong) UIActionSheet *actionSheet;
@end

@implementation CQFriendListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.collectionView.backgroundColor = [helper CQBackgroundColor];
      self.title = @"PEOPLE";
      
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.selected = 0;
  [self.navigationController.navigationBar setBackgroundImage:[helper imageWithColor: [helper CQGreenColor]] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.headerType = headerSelection;
  [self getParseFriendList];
  selectedIdx = [[NSMutableDictionary alloc] init];
  self.activity = [[NSUserDefaults standardUserDefaults] objectForKey:@"activity"];
//  self.activity = [[NSArray alloc] initWithObjects:@"Sking",@"hello",@"world", nil];
  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
  [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];

  [self.collectionView setAllowsMultipleSelection:YES];
  
  UIBarButtonItem *btnReset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(resetSelectedCells)];
  self.navigationItem.rightBarButtonItem = btnReset;
  
  UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
  [self.view addGestureRecognizer:gestureRecognizer];
  [gestureRecognizer setMinimumNumberOfTouches:1];
  [gestureRecognizer setMaximumNumberOfTouches:1];


	// Do any additional setup after loading the view.
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//  NSLog(@"update");
  return [self.friendList count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  
  UICollectionReusableView *reusableview = nil;
  
  if (kind == UICollectionElementKindSectionHeader) {
    reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    self.header = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 50)];
    self.headerLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:18.0];

    if (self.headerType == headerSelection) {
      self.header.backgroundColor = [UIColor whiteColor];
      self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 20)];
      self.headerLabel.backgroundColor = [UIColor clearColor];
      self.headerLabel.textColor = [UIColor colorWithRed:128/256.0 green:130/256.0 blue:133/256.0 alpha:1.0];
      self.headerLabel.text = [self.activity objectAtIndex:self.selected];
    } else if (self.headerType == headerSend) {
      self.header.backgroundColor = [helper CQGreenColor];
      self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 100, 20)];
      self.headerLabel.backgroundColor = [UIColor clearColor];
      self.headerLabel.textColor = [UIColor whiteColor];
      self.headerLabel.text = @"Send";
    }
    [self.header addSubview:self.headerLabel];

    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.header addGestureRecognizer:singleFingerTap];
    [reusableview addSubview:self.header];


    return reusableview;
  }
  
  if (kind == UICollectionElementKindSectionFooter) {
    UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    
    reusableview = footerview;
  }
  
  return reusableview;

}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  if (self.headerType == headerSelection) {
//    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Choose an activity"
//                                                      delegate:self
//                                             cancelButtonTitle:@"Okay"
//                                        destructiveButtonTitle:nil
//                                             otherButtonTitles:nil];
//    
//    UIPickerView *pickerView = [[UIPickerView alloc] init];
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
//    CGRect pickerRect = pickerView.bounds;
//    pickerRect.origin.y = 100;
//    pickerView.frame = pickerRect;
//    pickerView.showsSelectionIndicator = YES;
    
//    [menu addSubview:pickerView];
//    [menu showInView:self.view];
//    [menu setFrame:CGRectMake(0,150,320, 350)];
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Done"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.actionSheet addSubview:pickerView];
//    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"DONE"]];
//    closeButton.momentary = YES;
//    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
//    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
//    closeButton.tintColor = [UIColor blackColor];
//    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
//    [self.actionSheet addSubview:closeButton];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [self.actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
  } else if (self.headerType == headerSend) {
    NSLog(@"push notification");
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    
    //get selected user id in an nsarry
    //set that set channels
    //and push a message as "//myname wants to invite you to //Acivity tonight";
    
    // Send push notification to query
    
    NSArray *channels = [NSArray arrayWithObjects:@"Cliq", nil];
    PFPush *push = [[PFPush alloc] init];
//    PFUser *user = [PFUser currentUser];
    // Be sure to use the plural 'setChannels'.
    [push setChannels:channels];
    [push setMessage:@"Chenchen wants to invite you for Drinking tonight"];
    [push sendPushInBackground];
  }
}

-(void)dismissActionSheet {
  [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *identifier = @"Cell";
  
  UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
  
  if (![cell viewWithTag:selectedTag])
  {
    UILabel *selected = [[UILabel alloc] initWithFrame:CGRectMake(0, cellSize - textLabelHeight, cellSize, textLabelHeight)];
    selected.backgroundColor = [UIColor darkGrayColor];
    selected.textColor = [UIColor whiteColor];
    selected.text = @"SELECTED";
    selected.textAlignment = NSTextAlignmentCenter;
    selected.font = [UIFont systemFontOfSize:defaultFontSize];
    selected.tag = selectedTag;
    selected.alpha = cellAHidden;
    
    [cell.contentView addSubview:selected];
  }
  
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", [indexPath row] % numOfimg]]];
  [[cell viewWithTag:selectedTag] setAlpha:cellAHidden];
  cell.backgroundView.alpha = cellADeactive;
  
  // You supposed to highlight the selected cell in here; This is an example
  bool cellSelected = [selectedIdx objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
  [self setCellSelection:cell selected:cellSelected];
  
  
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(cellSize, cellSize);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  [self setCellSelection:cell selected:YES];
  
  [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
  NSLog(@"selected");
  self.headerType = headerSend;
  self.header.backgroundColor = [helper CQGreenColor];
  self.headerLabel.text = @"Send";
  self.headerLabel.textColor = [UIColor whiteColor];
  //  [self.collectionView reloadData];

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  [self setCellSelection:cell selected:NO];
  
  [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
  self.headerType = headerSelection;
  self.header.backgroundColor = [UIColor whiteColor];
  self.headerLabel.text = [self.activity objectAtIndex:self.selected];
  self.headerLabel.textColor = [UIColor colorWithRed:128/256.0 green:130/256.0 blue:133/256.0 alpha:1.0];

//  [self.collectionView reloadData];
}

- (void) setCellSelection:(UICollectionViewCell *)cell selected:(bool)selected
{
//  cell.backgroundView.alpha = selected ? cellAAcitve : cellADeactive;
  [cell viewWithTag:selectedTag].alpha = selected ? cellAAcitve : cellAHidden;

}

- (void) resetSelectedCells
{
  [self getParseFriendList];
  for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
    [self deselectCellForCollectionView:self.collectionView atIndexPath:[self.collectionView indexPathForCell:cell]];
  }
}

- (void) handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
  float pointerX = [gestureRecognizer locationInView:self.collectionView].x;
  float pointerY = [gestureRecognizer locationInView:self.collectionView].y;
  
  for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
    float cellSX = cell.frame.origin.x;
    float cellEX = cell.frame.origin.x + cell.frame.size.width;
    float cellSY = cell.frame.origin.y;
    float cellEY = cell.frame.origin.y + cell.frame.size.height;
    
    if (pointerX >= cellSX && pointerX <= cellEX && pointerY >= cellSY && pointerY <= cellEY)
      {
      NSIndexPath *touchOver = [self.collectionView indexPathForCell:cell];
      
      if (lastAccessed != touchOver)
        {
        if (cell.selected)
          [self deselectCellForCollectionView:self.collectionView atIndexPath:touchOver];
        else
          [self selectCellForCollectionView:self.collectionView atIndexPath:touchOver];
        }
      
      lastAccessed = touchOver;
      }
  }
  
  if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
    lastAccessed = nil;
    self.collectionView.scrollEnabled = YES;
    }
  
  
}

- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
  [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
  [self collectionView:collection didSelectItemAtIndexPath:indexPath];
}

- (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
  [collection deselectItemAtIndexPath:indexPath animated:YES];
  [self collectionView:collection didDeselectItemAtIndexPath:indexPath];
}


- (void)getParseFriendList
{
  [SVProgressHUD showWithStatus:@"Loading Friends"];
  NSLog(@"testQuery2");
  // Issue a Facebook Graph API request to get your user's friend list
  [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    if (!error) {
      // result will contain an array with your user's friends in the "data" key
      NSArray *friendObjects = [result objectForKey:@"data"];
      NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
      NSLog(@"friend count is %lu", (unsigned long)[friendObjects count]);
      // Create a list of friends' Facebook IDs
      for (NSDictionary *friendObject in friendObjects) {
        [friendIds addObject:[friendObject objectForKey:@"id"]];
      }
      
      // Construct a PFUser query that will find friends whose facebook ids
      // are contained in the current user's friend list.
      PFQuery *friendQuery = [PFUser query];
      [friendQuery whereKey:@"fbId" containedIn:friendIds];
      
      // findObjects will return a list of PFUsers that are friends
      // with the current user
      NSArray *friendUsers = [friendQuery findObjects];
      [self getFriendPictures: friendUsers];
      [SVProgressHUD dismiss];
    }
  }];
}


- (void)getFriendPictures:(NSArray *)users
{
  NSLog(@"users are %@", users);
  //  [self getFriendPictures];
  self.friendList = users;
  [self.collectionView reloadData];
  NSLog(@"count in flist is %lu", (unsigned long)[self.friendList count]);
  __block NSString *fbid;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    for (int i = 0; i < [users count]; i++) {
      fbid = [[users objectAtIndex:i] objectForKey:@"fbId"];
      NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", fbid]]];
      if (imgData) {
        UIImage *image = [UIImage imageWithData:imgData];
        if (image) {
          NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

          dispatch_async(dispatch_get_main_queue(), ^{
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            cell.backgroundView = [[UIImageView alloc] initWithImage:image];
            [self.collectionView reloadInputViews];
          });
        }
      }
    }
  });
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return CGSizeMake(0, 70);
  }
  
  return CGSizeZero;
}


- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  return [self.activity objectAtIndex:row];
}

@end
