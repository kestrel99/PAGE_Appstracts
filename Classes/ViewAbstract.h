//
//  ViewAbstract.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 13/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ViewAbstract : UIViewController
{
	NSNumber *abstractID;
	sqlite3 *abstractsDB;
    NSString *text;
    bool favourite;
}

@property (nonatomic, retain) NSNumber *abstractID;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
