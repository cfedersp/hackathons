//
//  CQSplashViewController.m
//  cliq
//
//  Created by Chenchen Zheng on 11/7/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "CQSplashViewController.h"

@interface CQSplashViewController ()

@end

@implementation CQSplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.title = @"Splash";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self createLogInButton];
}

- (void) createLogInButton
{
  UIButton *login = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.bounds) - 20, 50)];
  login.backgroundColor = [UIColor blackColor];
  login.titleLabel.text = @"test";
//  login.titleLabel.textColor =[UIColor whiteColor];
  [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:login];
}

- (void) login
{
  // FBSample logic
  // if the session is open, then load the data for our view controller
  if (!FBSession.activeSession.isOpen) {
    // if the session is closed, then we open it here, and establish a handler for state changes
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState state,
                                                      NSError *error) {
                                    if (error) {
                                      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                          message:error.localizedDescription
                                                                                         delegate:nil
                                                                                cancelButtonTitle:@"OK"
                                                                                otherButtonTitles:nil];
                                      [alertView show];
                                    } else if (session.isOpen) {
                                      NSLog(@"clip logged in");
                                      [self getUserInfo];

                                    }
                                  }];
    return;
  }
}

- (void) getUserInfo
{
    
    // Create a reference to a Firebase location
    Firebase* f = [[Firebase alloc] initWithUrl:@"https://cliq.firebaseIO.com/aldfdfwe2"];
    
  if (FBSession.activeSession.isOpen) {
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
      if (!error) {
        NSLog(@"print result %@", user);
//        i need likes, email, and phone number
          FBRequest* friendsRequest = [FBRequest requestForMyFriends];
          [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                        NSDictionary* result,
                                                        NSError *error) {
              NSArray* friends = [result objectForKey:@"data"];
              NSLog(@"Found: %i friends", friends.count);
              for (NSDictionary<FBGraphUser>* friend in friends) {
                  NSLog(@"I have a friend named %@ with id %@", friend.name, friend.id);
              }
          }];
          
          
          
          // Write data to Firebase
          [[f childByAutoId] setValue:@"Another chat message 2"];
          
          [[f childByAppendingPath:@"location"] setValue:@"South 1st Billiards"];
          [[f childByAppendingPath:@"time"] setValue:@"20:00"];
          
          
          // Read data and react to changes
          [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
              NSLog(@"%@ -> %@", snapshot.name, snapshot.value);
          }];
          
          
          PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
          [testObject setObject:@"bar" forKey:@"foo"];
          [testObject setObject:@"Charlie" forKey:@"name"];
          [testObject save];
          
          //Asynchronously call a url. (save this for later)
          // Create the request.
          //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];
          
          // Create url connection and fire request
          //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
      }
    }];
      
      
      
      
      
      
      
      
      
     
  }
}

//- (void) createView
//{
//    UILabel *name = [UILabel alloc] initWithFrame:CGRectMake(10, 200, CGRectGetWidth(self.view.bounds) - 20, <#CGFloat height#>)
//}








    // Use to parse json data
    //NSString *responseString = [request responseString];
    //NSLog(@"Got Facebook Profile: %@", responseString);
    
    //NSMutableDictionary *responseJSON = [responseString JSONValue];
    //NSArray *interestedIn = [responseJSON objectForKey:@"interested_in"];
    //if (interestedIn != nil) {
    //    NSString *firstInterest = [interestedIn objectAtIndex:0];
    //    if ([firstInterest compare:@"male"] == 0) {
    



#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSString *downloadeddata = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    // NSUTF8StringEncoding or NSASCIIStringEncoding
    NSLog(@"google result %@", downloadeddata);

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}
@end
