//
//  ViewChooseType.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 03/01/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewChooseCategory.h"

@interface ViewChooseType : UITableViewController
{
    NSArray *listData;    
}

@property(nonatomic, retain) NSArray *listData;

@end
