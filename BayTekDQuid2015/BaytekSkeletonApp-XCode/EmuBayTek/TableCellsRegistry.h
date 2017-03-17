//
//  TableCellsRegistry.h
//  EmuBayTek
//
//  Created by Dario Fiumicello on 13/02/15.
//  Copyright (c) 2015 DQuid S.r.l. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CELLS_REGISTRY [[TableCellsRegistry instance] registry]

#define CELL_DETAIL     @"DETAIL"
#define CELL_TEXTFIELD  @"TEXTFIELD"

@class UITableViewCell;

@interface TableCellsRegistry : NSObject

@property(nonatomic,strong) NSMutableArray* registry;

+ (TableCellsRegistry *) instance;

-(UITableViewCell*) getCellForCallbackSelName:(NSString*)callbackSelectorName;

@end
