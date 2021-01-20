//
//  AbstractCell.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 12/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractCell : UITableViewCell
{
    UILabel *code;
    UILabel *summary;
    UILabel *author;
    UILabel *date;
}

@property(nonatomic,retain) UILabel *code;
@property(nonatomic,retain) UILabel *summary;
@property(nonatomic,retain) UILabel *author;
@property(nonatomic,retain) UILabel *date;

@end
