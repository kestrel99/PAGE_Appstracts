//
//  AbstractCell.m
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 12/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import "AbstractCell.h"

@implementation AbstractCell

@synthesize code, summary, author, date;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.code = [[UILabel alloc] initWithFrame:CGRectZero];
        self.code.font = [UIFont fontWithName:@"helvetica" size:18];
        self.code.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.code];
        
        self.summary = [[UILabel alloc] initWithFrame:CGRectZero];
        self.summary.font = [UIFont fontWithName:@"helvetica" size:12];
        self.summary.lineBreakMode = NSLineBreakByWordWrapping;
        self.summary.numberOfLines = 0;
        [self addSubview:self.summary];
        
        self.author = [[UILabel alloc] initWithFrame:CGRectZero];
        self.author.font = [UIFont fontWithName:@"helvetica" size:12];
        self.author.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1];
        [self addSubview:self.author];
        
        self.date = [[UILabel alloc] initWithFrame:CGRectZero];
        self.date.font = [UIFont fontWithName:@"helvetica" size:12];
        self.date.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1];
        self.date.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.date];
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGSize textSize = [self.summary.text sizeWithFont:[UIFont fontWithName:@"helvetica" size:12]
                       constrainedToSize:CGSizeMake(self.frame.size.width - 80, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
    
    self.code.frame = CGRectMake(10,10,50,50);
    self.summary.frame = CGRectMake(70, 10, textSize.width, textSize.height);
    self.author.frame = CGRectMake(10, MAX(textSize.height+10, 50)+10, self.frame.size.width/2-20, 15);
    self.date.frame = CGRectMake(self.frame.size.width/2+10, MAX(textSize.height+10, 50)+10, self.frame.size.width/2-20, 15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
