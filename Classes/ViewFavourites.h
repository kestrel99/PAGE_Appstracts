//
//  ViewFavourites.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 20/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#include "AbstractCell.h"
#include "ViewAbstract.h"

@interface ViewFavourites : UITableViewController
{
    NSMutableArray *listData;
    sqlite3 *abstractsDB;
}

@end
