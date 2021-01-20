//
//  ViewAbout.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 16/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAbout : UIViewController
{
    NSMutableString *html;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
