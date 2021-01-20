//
//  Download.h
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 06/01/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewChooseType.h"

@interface Download : UIViewController
{
    NSMutableData *receivedData;
    int receiveStage;
    NSArray *abstractDataLines;
}

- (void) downloadNewDatabase:(UIWindow *)window;
@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end
