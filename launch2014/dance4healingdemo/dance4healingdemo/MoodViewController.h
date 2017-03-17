//
//  MoodViewController.h
//  dance4healingdemo
//
//  Created by Charlie Federspiel on 2/22/14.
//  Copyright (c) 2014 Charlie Federspiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodViewController : UIViewController <UIWebViewDelegate> {
    NSURL *theURL;
    NSString *theTitle;
    NSString *mood;
    IBOutlet UINavigationItem *webTitle;
    
    NSMutableDictionary *preferences;
    
}
//- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string;
- (IBAction) done:(id)sender;
@property (nonatomic, strong) NSMutableDictionary *preferences;
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) NSURL *theURL;
@property (strong, nonatomic) NSString *theTitle;
@end
