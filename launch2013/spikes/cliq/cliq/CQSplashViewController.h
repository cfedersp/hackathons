//
//  CQSplashViewController.h
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Firebase/Firebase.h>

@interface CQSplashViewController : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}

@end
