//
//  DQSecondViewController.m
//  DQuidAppTest
//
//  Created by Giorgio Scibilia on 23/04/14.
//  Copyright (c) 2014 DQuid s.r.l. All rights reserved.
//

#import "DQSecondViewController.h"
#import "DQTableViewCell.h"
#import "DQProperty.h"
#import "DQData.h"

@interface DQSecondViewController ()

@end

@implementation DQSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cellsForProperties = [NSMutableDictionary new];
    
    [_propertiesTableView setDelegate:self];
    [_propertiesTableView setDataSource:self];
    
    
    [_propertiesTableView reloadData];
    [_propertiesTableView reloadInputViews];
    
    _propertiesTableView.backgroundColor = [UIColor clearColor];
    
    [_connectedObject setDelegate:self];
    
    [_objectNameLabel setText:_connectedObject.name];
    [_objectSerialLabel setText:_connectedObject.serialNumber];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark - DQObjectDelegateProtocol

- (void) onErrorOccurred:(NSError *)error{
    NSLog(@"onErrorOccurred: %@", error);
}

-(void) onConnectionEstablished{
    NSLog(@"onConnectionEstablished");
}

- (void) onConnectionFailed{
    NSLog(@"onConnectionFailed");
}

- (void) onDisconnection{
    NSLog(@"onDisconnection");
    
    [self performSegueWithIdentifier:@"disconnectionSegue" sender:self];
}

- (void) onProperty:(DQProperty *)property receivedData:(DQData *)data{
    
    NSLog(@"\n\nonProperty:%@ receivedData:%@\n\n",property.name, data.description);
    
    DQTableViewCell *cell = _cellsForProperties[property.name];
    
    if(cell !=nil){
        [cell.readLabel setText:data.stringValue];
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[_connectedObject propertiesByName]allKeys]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DQProperty *tmpProp = [[_connectedObject propertiesByName]allValues][[indexPath row]];
    //    UITableViewCell *cell = [[UITableViewCell alloc]init];
    DQTableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil)
        cell = (DQTableViewCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if(cell.propertyNameLabel == nil)
        [cell setPropertyNameLabel:[UILabel new]];
    
    if(cell.subscribeSwitch == nil)
        [cell setSubscribeSwitch:[DQSwitch new]];
    
    if(cell.writeSwitch == nil)
        [cell setWriteSwitch:[DQSwitch new]];
    
    if(cell.writeTextField == nil)
        [cell setWriteTextField:[UITextField new]];
    
    if(cell.writeButton == nil)
        [cell setWriteButton:[DQButton new]];
    
    if(cell.readLabel == nil)
        [cell setReadLabel:[UILabel new]];
    
    if(cell.readButton == nil)
        [cell setReadButton:[DQButton new]];
    
    [cell.propertyNameLabel setText:tmpProp.name];
    
    [cell.subscribeSwitch setPropertyName:tmpProp.name];
    [cell.writeSwitch setPropertyName:tmpProp.name];
    [cell.readButton setPropertyName:tmpProp.name];
    [cell.writeButton setPropertyName:tmpProp.name];
    
    [cell.subscribeSwitch addTarget:self action:@selector(subscribeSwitchTouched:) forControlEvents:UIControlEventValueChanged];
    
    if([tmpProp isReadable]){
        [cell.readLabel setEnabled:YES];
        [cell.readLabel setUserInteractionEnabled:NO];
        
        [cell.readButton setEnabled:YES];
        [cell.readButton setUserInteractionEnabled:YES];
        [cell.readButton addTarget:self action:@selector(readButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    } else{
        [cell.readLabel setEnabled:NO];
        [cell.readLabel setUserInteractionEnabled:NO];
        
        [cell.readButton setEnabled:NO];
        [cell.readButton setUserInteractionEnabled:NO];
    }
    
    if([tmpProp isWritable]){
        if(tmpProp.writeDataType == DQ_BOOLEAN){
            [cell.writeSwitch setHidden:NO];
            [cell.writeSwitch setEnabled:YES];
            [cell.writeSwitch setUserInteractionEnabled:YES];
            [cell.writeSwitch addTarget:self action:@selector(writeSwitchTouched:) forControlEvents:UIControlEventValueChanged];
            
            [cell.writeTextField setHidden:YES];
            [cell.writeTextField setEnabled:NO];
            [cell.writeTextField setUserInteractionEnabled:NO];
            
            [cell.writeButton setEnabled:YES];
            [cell.writeButton setUserInteractionEnabled:NO];
            
        } else{
            [cell.writeSwitch setHidden:YES];
            [cell.writeSwitch setEnabled:NO];
            [cell.writeSwitch setUserInteractionEnabled:NO];
            
            [cell.writeTextField setHidden:NO];
            [cell.writeTextField setEnabled:YES];
            [cell.writeTextField setUserInteractionEnabled:YES];
            [cell.writeTextField setDelegate:self];
            
            [cell.writeButton setEnabled:YES];
            [cell.writeButton setUserInteractionEnabled:YES];
            [cell.writeButton addTarget:self action:@selector(writeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    } else{
        if(tmpProp.writeDataType == DQ_BOOLEAN){
            [cell.writeSwitch setHidden:NO];
            [cell.writeSwitch setEnabled:NO];
            [cell.writeSwitch setUserInteractionEnabled:YES];
            
            [cell.writeTextField setHidden:YES];
            [cell.writeTextField setEnabled:NO];
            [cell.writeTextField setUserInteractionEnabled:NO];
            
            [cell.writeButton setEnabled:NO];
            [cell.writeButton setUserInteractionEnabled:NO];
            
        } else{
            [cell.writeSwitch setHidden:YES];
            [cell.writeSwitch setEnabled:NO];
            [cell.writeSwitch setUserInteractionEnabled:NO];
            
            [cell.writeTextField setHidden:NO];
            [cell.writeTextField setEnabled:NO];
            [cell.writeTextField setUserInteractionEnabled:YES];
            
            [cell.writeButton setEnabled:NO];
            [cell.writeButton setUserInteractionEnabled:NO];
        }
        
    }
    
    _cellsForProperties[tmpProp.name] = cell;
    
    return cell;
}




#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - IBActions

- (IBAction) readButtonPressed:(id)sender{
    DQButton *button = (DQButton*)sender;
    [_connectedObject dqReadProperty:button.propertyName subscribe:NO];
}


- (IBAction) subscribeSwitchTouched:(id)sender{
    DQSwitch *switchInCell = (DQSwitch *)sender;
    
    if(switchInCell.isOn)
        [_connectedObject dqReadProperty:switchInCell.propertyName subscribe:YES];
    else
        [_connectedObject dqUnsusbcribeFromProperty:switchInCell.propertyName];
        
}


- (IBAction) writeSwitchTouched:(id)sender{
    DQSwitch *switchInCell = (DQSwitch *)sender;
    [_connectedObject dqWriteBool:switchInCell.isOn toProperty:switchInCell.propertyName];
}


- (IBAction) writeButtonPressed:(id)sender{
    DQButton *button = (DQButton*)sender;
    [_connectedObject dqReadProperty:button.propertyName subscribe:NO];
}



- (IBAction) disconnect:(id)sender{
    [_connectedObject dqDisconnect];
}



@end
