//
//  TxDocumentsTableViewController.m
//  zoomex
//
//  Created by Charlie Federspiel on 6/29/14.
//  Copyright (c) 2014 Integration Specialists. All rights reserved.
//

#import "TxDocumentsTableViewController.h"
#import "IndexedUISwitch.h"
#import "DocumentTableViewCell.h"

@interface TxDocumentsTableViewController ()

@end

@implementation TxDocumentsTableViewController

@synthesize parentItem;
@synthesize detailItem;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = detailItem.address1;
    txDocuments = [[NSMutableArray alloc] initWithCapacity:10];
    NSLog(@"loading cell nib");
    nib = [[NSBundle mainBundle] loadNibNamed:@"DocumentCell" owner:self options:nil];
    
    NSLog(@"Refreshing transaction: %@", detailItem.objectId);
    PFQuery *transactionRefreshQuery = [PFQuery queryWithClassName:@"Transaction"];
    [transactionRefreshQuery getObjectInBackgroundWithId:detailItem.objectId block:^(PFObject* foundTx, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved transaction: %@", foundTx.objectId);
            
            PFRelation *documentRelations = foundTx[@"documents"];
            [[documentRelations query] findObjectsInBackgroundWithBlock:^(NSArray *foundDocuments, NSError *error) {
                if (!error) {
                    for (PFObject *document in foundDocuments) {
                        ZoomRexDocument* currentDocument = [[ZoomRexDocument alloc] init];
                        NSLog(@"loading doc: %@", document.objectId);
                        [currentDocument setObjectId:document.objectId];
                        [currentDocument setShortName:document[@"shortName"]];
                        [currentDocument setDescription:document[@"description"]];
                        [currentDocument setStatus:document[@"status"]];
                        [txDocuments addObject:currentDocument];
                    }
                    
                    if(txDocuments.count > 0) {
                        NSLog(@"reloading docs view %d", txDocuments.count);
                        dispatch_async(dispatch_get_main_queue(), ^ {
                            [self.tableView reloadData];
                        });
                    } else {
                        NSLog(@"docs found %d", txDocuments.count);
                    }
                } else {
                    NSLog(@"error retrieving docs in transaction");
                }
            }];
            
        } else {
            NSLog(@"transaction with ID: %@ not found.", foundTx.objectId);
            
        }
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return txDocuments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZoomRexDocument* d = [self->txDocuments objectAtIndex:[indexPath row]];
    
    DocumentTableViewCell *cell = (DocumentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"documentListItem" forIndexPath:indexPath];
    IndexedUISwitch *toggleSwitch;
    if(cell == NULL) {
        //cell = [[DocumentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DocumentCell"] ;
        cell = [nib objectAtIndex:0];
        
        if(switchControls.count >[indexPath row]) {
            toggleSwitch = [switchControls objectAtIndex:[indexPath row]];
        } else {
            toggleSwitch = [[IndexedUISwitch alloc] init];
        }
        
        cell.document = d;
        cell.documentStatusSwitch = toggleSwitch;
    }
    
    toggleSwitch.offset = [indexPath row];
        
        //[toggleSwitch addTarget:self
        //             action:@selector(changeDocumentStatus:)
        //   forControlEvents:UIControlEventValueChanged];
        
    
    cell.accessoryView = [[UIView alloc] initWithFrame:toggleSwitch.frame];
    [cell.accessoryView addSubview:toggleSwitch];

    
    
    NSLog(@"showing row: %d", toggleSwitch.offset);
    // Configure the cell...
    cell.textLabel.text = [d.shortName stringByAppendingString:d.status];
    
    
    NSLog(@"showing cell: %@", d.shortName);
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
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

@end
