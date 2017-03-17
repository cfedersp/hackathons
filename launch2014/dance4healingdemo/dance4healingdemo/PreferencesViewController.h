//
//  ViewController.h
//  dance4healingdemo
//
//  Created by Charlie Federspiel on 2/21/14.
//  Copyright (c) 2014 Charlie Federspiel. All rights reserved.
//

#import <UIKit/UIKit.h>
// @interface PreferencesViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource> {
// is same as
// @interface ViewController : UITableViewController  <UITableViewDataSource> {
// when using tableviewcontroller in the storyboard

@interface PreferencesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSArray *genres;
    NSMutableDictionary *preferences;
    
    __weak IBOutlet UITableView *genresTableView; // not using this for anything but ok to have it
}
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, weak) UITableView *genresTableView;
@property (nonatomic, strong) NSMutableDictionary *preferences;
-(IBAction)savePreferencesButtonPressed:(id)sender;
@end



