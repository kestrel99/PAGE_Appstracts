//
//  ViewChooseType.m
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 03/01/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import "ViewChooseType.h"

@interface ViewChooseType ()

@end

@implementation ViewChooseType

@synthesize listData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Programme Item",@"Abstract Category",@"Presenter",nil];
	
	self.listData=array;
    
	self.navigationItem.title = @"View Abstract by";	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSUInteger row = [indexPath row];
	//cell.textLabel.font = [UIFont systemFontOfSize:14];
	cell.textLabel.text = [listData objectAtIndex:row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewChooseCategory *childController;

    NSUInteger row = [indexPath row];
	if (childController == nil)
    {
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        childController = (ViewChooseCategory*)[sb instantiateViewControllerWithIdentifier:@"chooseCategory"];
        //childController = [[ViewChooseCategory alloc] init];
    }
	childController.title = [listData objectAtIndex:row];
	
	if (row == 0) {
		childController.viewType = @"Grp";
		childController.orderType = @"Grp";
	}
    if (row == 1) {
		childController.viewType = @"type";
		childController.orderType = @"type";
	}
	if (row == 2) {
		childController.viewType = @"fullname";
		childController.orderType = @"fullname";
	}
    
	[self.navigationController pushViewController:childController animated:YES];
}

@end
