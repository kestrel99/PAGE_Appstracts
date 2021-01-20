//
//  ViewChooseCategory.m
//  Page Appstracts
//
//  Created by Hendrik Schoemaker on 03/01/2013.
//  Copyright (c) 2013 Hendrik Schoemaker. All rights reserved.
//

#import "ViewChooseCategory.h"

@interface ViewChooseCategory ()

@end

@implementation ViewChooseCategory

@synthesize listData, viewType, orderType;

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

    NSString* fileToSaveTo = @"PageAbstracts";
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString* documentsDirectory = [path objectAtIndex:0];
    NSString *databasePath = [NSString stringWithFormat:@"%@/%@.sqlite",documentsDirectory,fileToSaveTo];
    
	const char *dbpath = [databasePath UTF8String];
	
	sqlite3_stmt *statement;
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	if (sqlite3_open(dbpath, &abstractsDB) == SQLITE_OK) {
		NSString *querySQL = [NSString stringWithFormat: @"SELECT DISTINCT \"%@\"  FROM Abstracts WHERE (( (lastname & ',  ' & firstname)) <> ' ,  ') ORDER BY \"%@\"", viewType, orderType];
		const char *query_stmt = [querySQL UTF8String];
		
        int prepareStatus = sqlite3_prepare_v2(abstractsDB, query_stmt, -1, &statement, NULL);
        if(prepareStatus == SQLITE_OK) {
			while (sqlite3_step(statement) == SQLITE_ROW) {
				if (sqlite3_column_text(statement,0)) {
					
                    NSString *text = @"";
                    if (sqlite3_column_text(statement,0))
                        text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement,0)];
                    
                    [array addObject:text];
                    
					//[text release];
				}
			}
			sqlite3_finalize(statement);
		}else{
            NSLog(@"Prepare-error #%i: %s", prepareStatus, sqlite3_errmsg(abstractsDB));
        }
        
		sqlite3_close(abstractsDB);
	}
    
    if ([viewType isEqual: @"fullname"])
        categoryIndex = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",
                         @"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    else
        categoryIndex = [[NSMutableArray alloc]initWithObjects:@"Oral", @"Poster", @"Software", nil];
                 
    
    NSMutableArray *allArrays = [[NSMutableArray alloc] init];
	
    for (int i=0; i<[categoryIndex count]; i++)
    {
        NSString *predStr = [NSString stringWithFormat:@"SELF beginswith[c] '%@'", [categoryIndex objectAtIndex:i]];
        NSPredicate *pred = [NSPredicate predicateWithFormat:predStr];
        NSArray *arrayWithLetter = [array filteredArrayUsingPredicate:pred];
        
        if ([arrayWithLetter count]>0)
            [allArrays addObject: arrayWithLetter];
        else
        {
            [categoryIndex removeObjectAtIndex:i];
            i--;
        }
    }
    
    self.listData=allArrays;
	
	//[super viewWillAppear:animated];
	
	[[self tableView] reloadData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [listData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return[[listData objectAtIndex:section] count];
}

/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [listOfItems objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Countries"];
    return [array count];
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
	NSArray *array = [listData objectAtIndex: indexPath.section];
    
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([viewType isEqual: @"fullname"])
        return categoryIndex;
    return NULL;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index % [listData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [categoryIndex objectAtIndex: section];
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
    ViewChooseAbstract *childController;
    
    if (childController == nil)
    {
        UIStoryboard* sb = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        childController = (ViewChooseAbstract*)[sb instantiateViewControllerWithIdentifier:@"chooseAbstract"];
    }
    NSArray *array = [listData objectAtIndex: indexPath.section];
	childController.title = [array objectAtIndex:indexPath.row];
	
    NSString *category = [NSString stringWithFormat:@"%@",[array objectAtIndex:indexPath.row]];
	childController.category = category;
	childController.viewType = viewType;
	
	[self.navigationController pushViewController:childController animated:YES];
}

@end
