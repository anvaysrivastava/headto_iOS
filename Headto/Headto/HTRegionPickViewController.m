//
//  HTRegionPickViewController.m
//  Headto
//
//  Created by Anvay Srivastava on 13/12/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import "HTRegionPickViewController.h"
#import "HTRegionElement.h"

@interface HTRegionPickViewController ()

@property NSMutableArray *pastRegions;
@property NSMutableArray *searchResults;
@property IBOutlet UISearchBar *searchBar;

@end

@implementation HTRegionPickViewController

#pragma mark - Lifecycle methods


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initDefaultRegions
{
    HTRegionElement *firstElement = [[HTRegionElement alloc] init];
    firstElement.regionName = @"Delhi";
    [self.pastRegions addObject:firstElement];
    HTRegionElement * secondElement = [[HTRegionElement alloc] init];
    secondElement.regionName = @"Chennai";
    [self.pastRegions addObject:secondElement];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pastRegions = [ [NSMutableArray alloc] init];
    [self initDefaultRegions];
    self.selectedRegion = NULL;
    self.searchResults = [[NSMutableArray alloc] initWithArray:self.pastRegions];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma Table population

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *selectedArray = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        selectedArray = self.searchResults;
    } else {
        selectedArray = self.pastRegions;
    }
    
    self.selectedRegion = [selectedArray objectAtIndex:indexPath.row];
    NSLog(@"Changing the selectedRegion to %@",self.selectedRegion.regionName);
    [self.delegate setRegion:self.selectedRegion];
    [self.navigationController popViewControllerAnimated:true];
    //[self dismissViewControllerAnimated:TRUE completion:nil];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return @"";
    } else {
        return @"Past Search";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == self.searchDisplayController.searchResultsTableView){
        return [self.searchResults count];
    } else {
        return [self.pastRegions count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RegionPickerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    HTRegionElement *presentElement = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView){
        presentElement = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        presentElement = [self.pastRegions objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = presentElement.regionName;
    return cell;
}

#pragma view switches

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma search display controller

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    HTRegionElement *tempRegionObject = [[HTRegionElement alloc] init];
    tempRegionObject.regionName = searchString;
    [self.searchResults addObject:tempRegionObject];
    return YES;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [ self.pastRegions removeObject:[self.pastRegions objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Modification to HTRegionPickViewController is not a Delete action");
    }
}


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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
