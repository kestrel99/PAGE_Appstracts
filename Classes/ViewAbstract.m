//
//  ViewAbstract.m
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 13/02/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import "ViewAbstract.h"

@interface ViewAbstract ()

@end

@implementation ViewAbstract

@synthesize webView, abstractID;

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
	
    NSString* fileToSaveTo = @"PageAbstracts";
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* documentsDirectory = [path objectAtIndex:0];
    NSString *databasePath = [NSString stringWithFormat:@"%@/%@.sqlite",documentsDirectory,fileToSaveTo];
    
	const char *dbpath = [databasePath UTF8String];
    
	sqlite3_stmt *statement;
	
	if (sqlite3_open(dbpath, &abstractsDB) == SQLITE_OK) {
		NSString *querySQL = [NSString stringWithFormat: @"SELECT type, firstname, lastname, number, title, author, affiliation, content FROM Abstracts WHERE _id=\"%@\"", abstractID];
		const char *query_stmt = [querySQL UTF8String];
		
		if (sqlite3_prepare_v2(abstractsDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				
                NSString *type = @"";
                if (sqlite3_column_text(statement,0))
                    type = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,0)];
				
                NSString *firstname = @"";
                if (sqlite3_column_text(statement,1))
                    firstname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,1)];
				
                NSString *lastname = @"";
                if (sqlite3_column_text(statement,2))
                    lastname = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,2)];
                
                NSString *number = @"";
                if (sqlite3_column_text(statement,3))
                    number = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,3)];
				
                NSString *abstractTitle = @"";
                if (sqlite3_column_text(statement,4))
                    abstractTitle = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,4)];
                
                NSString *author = @"";
                if (sqlite3_column_text(statement,5))
                    author = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,5)];
                
				NSString *affiliation = @"";
                if (sqlite3_column_text(statement,6))
                    affiliation = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,6)];
				
                NSString *content = @"";
                if (sqlite3_column_text(statement,7))
                    content = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,7)];
				
				text = [NSString stringWithFormat:@"<html><head><style type='text/css'>body {font-family: Helvetica;}</style></head></html><p align=right>%@<BR><HR></p><H3><center><I>%@ %@ </I> <b>%@ %@ </b></center></H3><p><center>%@<br><I>%@</I></center></p><p>%@</p>", type, firstname, lastname, number, abstractTitle, author, affiliation, content];
                
				[webView loadHTMLString:text baseURL:nil];
				self.title = number;
                
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(abstractsDB);
	}
    
    [self loadFavourite];
    	 
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
    
    [self loadFavourite];
}

-(void) loadFavourite
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *abstractSelected = [[NSArray alloc] init];
    if ([defaults arrayForKey:@"abstractSelected"]) {
		abstractSelected = [NSArray arrayWithArray:[defaults arrayForKey:@"abstractSelected"]];
	}
    
    favourite = false;
    
    //if ([abstractSelected containsObject:abstractID])
    //favourite = true;
    
    
	for (int i=0;i<[abstractSelected count];i++)
		if ([[abstractSelected objectAtIndex:i] isEqualToNumber:abstractID])
        {
			favourite = true;
            break;
		}
	
    UIBarButtonItem *favouriteButton = [[UIBarButtonItem alloc] initWithTitle:@"☆" style: UIBarButtonItemStyleBordered target:self action:@selector(setFavourite:)];
    
    self.navigationItem.rightBarButtonItem = favouriteButton;
    
	if (favourite)
        favouriteButton.title = @"★";
}

-(IBAction)setFavourite:(UIBarButtonItem *)sender {
	favourite = !favourite;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSMutableArray *abstractSelected = [[NSMutableArray alloc] init];
    if ([defaults arrayForKey:@"abstractSelected"]) {
		abstractSelected = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"abstractSelected"]];
	}

    if (favourite)
    {
        sender.title = @"★";
        [abstractSelected addObject:abstractID];
    }
    else
    {
        sender.title = @"☆";
        
        for (int i=0;i<[abstractSelected count];i++)
            if ([[abstractSelected objectAtIndex:i] isEqualToNumber:abstractID])
                [abstractSelected removeObjectAtIndex:i];
    }
    
    [defaults setObject:abstractSelected forKey:@"abstractSelected"];
    [defaults synchronize];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (UIWebViewNavigationTypeLinkClicked == navigationType) {
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}

- (void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation duration: (NSTimeInterval)duration
{
    [webView loadHTMLString:text baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
