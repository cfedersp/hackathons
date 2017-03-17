//
//  CQActivitiesViewController.h
//  activity
//
//  Created by Chenchen Zheng on 11/8/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

typedef NS_ENUM(NSUInteger, ActivitiesTypes) {
  FREE,
  BUSY
};

@interface CQActivitiesViewController : UIViewController <RNFrostedSidebarDelegate>

@property (nonatomic) ActivitiesTypes type;

@end
