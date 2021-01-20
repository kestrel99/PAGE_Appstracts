//
//  ViewChooseCategory.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 03/01/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "ViewChooseAbstract.h"

@interface ViewChooseCategory : UITableViewController
{
	NSString *orderType;
	NSString *viewType;
	NSArray *listData;
	NSMutableArray *categoryIndex;
    
	//ViewByCategoryController *childController;
	
	sqlite3 *abstractsDB;
}

@property(nonatomic,retain) NSString *viewType;
@property(nonatomic,retain) NSString *orderType;
@property(nonatomic,retain) NSArray *listData;

@end
