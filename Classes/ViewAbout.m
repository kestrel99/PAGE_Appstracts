//
//  ViewAbout.m
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 16/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import "ViewAbout.h"

@interface ViewAbout ()

@end

@implementation ViewAbout

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self loadAbout];
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
    
    [self loadAbout];
}


- (void) loadAbout
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PAGE" ofType:@"html"];
	html = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if ([defaults stringForKey:@"VersionDate"] != NULL)
        [html appendFormat:@"<center>Abstract version date:<br> %@</center>",[defaults stringForKey:@"VersionDate"]];
    
    [html appendFormat:@"<br><br><br><br></body></html>"];
    
    [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (UIWebViewNavigationTypeLinkClicked == navigationType) {
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration: (NSTimeInterval)duration
{
    //if (html != NULL)
        [self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
