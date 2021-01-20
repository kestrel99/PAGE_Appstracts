//
//  Download.m
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 06/01/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import "Download.h"

@implementation Download

//@synthesize indicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self downloadNewDatabase];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.autoresizesSubviews = YES;
    
    //[indicator startAnimating];
}

- (void) downloadNewDatabase : (UIWindow *) window {
    self.window = window;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //[defaults setObject:nil forKey:@"VersionDate"];
    //[defaults synchronize];
    
    NSError *error = nil;
    NSURLResponse *response = nil;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.page-meeting.org/page/App/PAGEAbstracts.sqlite"]];
    [request setHTTPMethod:@"HEAD"];
    [request setTimeoutInterval:30.0];
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    if (error != nil)
        NSLog(@"Error while downloading database header: %@", error);
    else
    {
        if (![response isMemberOfClass:[NSHTTPURLResponse class]])
            NSLog(@"Response is not a NSHTTPURLResponse");
        else
        {
            NSLog(@"Downloaded database metadata!");
            NSLog(@"AllHeaderFields: %@", [((NSHTTPURLResponse *)response) allHeaderFields]);

            NSDate *versionDate = (NSDate *)[[((NSHTTPURLResponse *)response) allHeaderFields] objectForKey:@"Last-Modified"];
            
            if (versionDate == nil)
                NSLog(@"Database metadata does not contain Last-Modified property");
            else
            {
                NSDate *oldVersionDate  = (NSDate *)[defaults objectForKey:@"VersionDate"];
                NSLog(@"Version Date: %@", versionDate);
                NSLog(@"Old Version Date: %@", oldVersionDate);
                
                if (oldVersionDate != nil && [versionDate compare:oldVersionDate] == NSOrderedSame)
                    NSLog(@"Database is up to date");
                else
                {
                    [request setHTTPMethod:@"GET"];
                    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
                    if (error != nil || result == nil)
                        NSLog(@"Error while downloading database: %@", error);
                    else
                    {
                        NSLog(@"Downloaded new database!");
                        
                        NSString* fileToSaveTo = @"PageAbstracts";
                        NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
                        NSString* documentsDirectory = [path objectAtIndex:0];

                        [result writeToFile:[NSString stringWithFormat:@"%@/%@.sqlite",documentsDirectory,fileToSaveTo] atomically:YES];
                        [defaults setObject:versionDate forKey:@"VersionDate"];
                        [defaults synchronize];
                    }
                    
                }
            }
        }
    }
    
    [self startMainController];
}

/*
- (void) downloadNewDatabase : (UIWindow *) window {
    self.window = window;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults stringForKey:@"DBversion"])
    {
        [defaults setObject:@"" forKey:@"VersionDate"];
        [defaults setObject:@"" forKey:@"DBversion"];
        [defaults synchronize];
    }

    receiveStage = 0;

    // Create the request.
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.page-meeting.org/page/App/DBversion.txt"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection)
    {
        receivedData = [[NSMutableData alloc] init];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    else
    {
        NSLog(@"Couldn't setup a connection");
        [self startMainController];
    }

}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self startMainController];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (receiveStage)
    {
        case 0: // checking if there is a new database
        {
            NSMutableString *dbVersion  = [NSMutableString stringWithFormat:@"%@", [defaults stringForKey:@"DBversion"]];
            
            if (receivedData != NULL)
            {
                NSString *dataString = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding: NSUTF8StringEncoding];
                abstractDataLines = [dataString componentsSeparatedByString:@"\n"];
                
                if (![[abstractDataLines objectAtIndex:0] isEqualToString: dbVersion])
                {
                    receiveStage = 1;
                    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.page-meeting.org/page/App/PAGEAbstracts.sqlite"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
                    
                    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
                    
                    if (theConnection)
                    {
                        receivedData = [[NSMutableData alloc] init];
                        [self.window.rootViewController.view addSubview: self.view];
                    }
                    else
                    {
                        NSLog(@"Couldn't setup a connection");
                        [self startMainController];
                    }
                }else{
                    [self startMainController];
                }
            }
            
            break;
        }
        case 1: // downloading new database
        {
            NSString* fileToSaveTo = @"PageAbstracts";
            NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString* documentsDirectory = [path objectAtIndex:0];
            
            if (receivedData != NULL)
            {
                [receivedData writeToFile:[NSString stringWithFormat:@"%@/%@.sqlite",documentsDirectory,fileToSaveTo] atomically:YES];
            
                if ([abstractDataLines objectAtIndex:0] != NULL)
                    [defaults setObject:[abstractDataLines objectAtIndex:0] forKey:@"DBversion"];
            
                if ([abstractDataLines objectAtIndex:1] != NULL)
                    [defaults setObject:[abstractDataLines objectAtIndex:1] forKey:@"VersionDate"];
            }
            
            [defaults synchronize];
            [self startMainController];
            
            break;
        }
    }
    
    //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
}*/

- (void) startMainController
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.view removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
