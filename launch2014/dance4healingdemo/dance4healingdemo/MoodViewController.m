//
//  MoodViewController.m
//  dance4healingdemo
//
//  Created by Charlie Federspiel on 2/22/14.
//  Copyright (c) 2014 Charlie Federspiel. All rights reserved.
//

#import "MoodViewController.h"
#import "SearchResultsTableViewController.h"

@interface MoodViewController ()

@end

@implementation MoodViewController
@synthesize preferences;
@synthesize theURL;
@synthesize theTitle;


 
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:theURL];
    [_myWebView loadRequest:requestObj];
    NSLog(@"loaded web view: %@", theURL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if([request URL] != nil) {
        NSString *tmpString = [[request URL] absoluteString];
        //NSLog(@"passed data from web view : %@",tmpString);
        
        if([tmpString isEqualToString:@"http://dance4healing/happy"])
        {
            mood = @"HAPPY";
            [self performSegueWithIdentifier: @"PerformMusicSearchSegue" sender: self];
            
            NSLog(@"Selected mood: %@", mood);
            return NO;
            
        } else if([tmpString isEqualToString:@"http://dance4healing/sad"])
        {
            mood = @"SAD";
            [self performSegueWithIdentifier: @"PerformMusicSearchSegue" sender: self];
            
            
            NSLog(@"Selected mood: %@", mood);
            return NO;
            
        }
        
    }
    NSLog(@"YES!");
    return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://ohterrariums.com/dance/assets/www/healing.html"];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PerformMusicSearchSegue"]) {
        SearchResultsTableViewController *destViewController = segue.destinationViewController;
        destViewController.preferences = preferences;
        destViewController.mood = mood;
    }
}

@end
