//
//  ViewChooseAbstract.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 12/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#include "AbstractCell.h"
#include "ViewAbstract.h"

@interface ViewChooseAbstract : UITableViewController
{
    NSString *category;
	NSString *viewType;
	NSArray *listData;
	
	sqlite3 *abstractsDB;
}

@property(nonatomic,retain) NSString *category;
@property(nonatomic,retain) NSString *viewType;
@property(nonatomic,retain) NSArray *listData;

@end
