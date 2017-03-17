//
//  SearchResultsTableViewController.h
//  dance4healingdemo
//
//  Created by Charlie Federspiel on 2/22/14.
//  Copyright (c) 2014 Charlie Federspiel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsTableViewController : UITableViewController {
    NSMutableDictionary *preferences;
    NSString *mood;
    
}
@property (nonatomic, strong) NSMutableDictionary *preferences;
@property (nonatomic, strong) NSString *mood;

@end
