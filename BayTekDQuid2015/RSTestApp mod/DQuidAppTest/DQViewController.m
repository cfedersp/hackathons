//
//  DQViewController.m
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 22/01/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import "DQViewController.h"
#import "DQProperty.h"
#import "DQData.h"

@interface DQViewController ()

@end

@implementation DQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_objectsTableView setDelegate:self];
    [_objectsTableView setDataSource:self];

    [self refreshListView];
    
//    [DQMANAGER enableLogs];
    
    [DQMANAGER setDelegate:self];
    
    [_activityWheel stopAnimating];
    _objectsTableView.backgroundColor = [UIColor clearColor];
    [DQMANAGER dqDiscover];
    [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshListView) userInfo:nil repeats:YES] fire];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) refreshListView{
    _objectsArray = [DQMANAGER dqKnownObjects];
    if(_objectsArray == nil)
        _objectsArray = [NSArray new];
    [_objectsTableView reloadData];
    [_objectsTableView reloadInputViews];
}


#pragma mark - DQManagerDelegateProtocol

- (void)onNewObjectDiscovered:(DQObject *)object{
    NSLog(@"onNewObjectDiscovered! %@", object.name);
    [self refreshListView];
}

- (void) onErrorOccurred:(NSError *)error{
    NSLog(@"onErrorOccurred: %@", error);
}

-(void) onConnectionEstablishedForObject:(DQObject*)object{
    NSLog(@"onConnectionEstablishedForObject: %@ - %@", object.name, object.serialNumber);
    [_activityWheel stopAnimating];
    [self performSegueWithIdentifier:@"connectionEstablishedSegue" sender:self];
}

- (void) onConnectionFailedForObject:(DQObject*)object{
    NSLog(@"onConnectionFailedForObject: %@ - %@", object.name, object.serialNumber);
    [_activityWheel stopAnimating];
}

- (void) onDisconnectionFromObject:(DQObject*)object{
    NSLog(@"onDisconnectionFromSerial: %@ - %@", object.name, object.serialNumber);
    [_activityWheel stopAnimating];
}

- (void) onProperty:(DQProperty *)property ofObject:(DQObject *)object receivedData:(DQData *)data{
    NSLog(@"onProperty:%@ ofObject:%@ receivedData: %@", property.name, object.name, data.description);
}

- (void) onDQObjectInRange{
    NSLog(@"onDQObjectInRange");
}


#pragma mark - IBActions

- (IBAction) startDiscovery:(id)sender{
    [DQMANAGER dqDiscover];
}


- (IBAction) clearObjects:(id)sender{
    [DQMANAGER dqClearKnownObjects];
    [self refreshListView];
}


- (IBAction) updateConfigurations:(id)sender{
    [DQMANAGER dqUppdateKnownObjectsConfigurations];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedObject = _objectsArray[[indexPath row]];
    [_selectedObject dqConnect];
    [_activityWheel startAnimating];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_objectsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DQObject *object = _objectsArray[[indexPath row]];
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyCell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@\n", object.name, object.serialNumber];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Last Seen: %@", object.lastSeen];
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    _svc = (DQSecondViewController*) segue.destinationViewController;
    [_svc setConnectedObject:_selectedObject];
}


@end
