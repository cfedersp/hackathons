//
//  CQFriendListViewController.h
//  activity
//
//  Created by Chenchen Zheng on 11/9/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, headerType) {
  headerSelection,
  headerSend
};
@interface CQFriendListViewController : UICollectionViewController
{
  CGPoint dragStartPt;
  bool dragging;
  
  NSMutableDictionary *selectedIdx;
}

@property (nonatomic, strong) NSArray* friendList;
@property (nonatomic) headerType headerType;
@end
