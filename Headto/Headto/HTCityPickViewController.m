//
//  HTCityViewController.m
//  Headto
//
//  Created by Anvay Srivastava on 09/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import "HTCityPickViewController.h"

@interface HTCityPickViewController ()

@end

@implementation HTCityPickViewController

NSMutableArray *cities;
NSURL *searchUrl;
int requestCount=0;
int modificationCount=0;
@synthesize delegate;
@synthesize citySearchTableView=_citySearchTableView;
@synthesize citySerchBar=_citySerchBar;


- (void) triggerSearch:(NSString *)query withModificationCount:(int)modificationCount
{
    NSString *searchString =  [[ NSString stringWithFormat:@"http://ws.geonames.org/searchJSON?name_startsWith=%@",query] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    searchUrl = [ [NSURL alloc] initWithString:searchString];
    NSLog(@"Search url is %@",searchUrl);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:searchUrl
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSError *requrestJSONConversionError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    if(response == NULL){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:response
                                                                     options: NSJSONReadingMutableContainers
                                                                       error: &requrestJSONConversionError];
        //NSLog(@"Response has been recieved for citypick %@ ",responseJSON);
        if(requestCount<=modificationCount){
            cities = [responseJSON valueForKey:@"geonames"];
            requestCount = modificationCount;
            [self.citySearchTableView reloadData];
        } else {
            NSLog(@"Search request cancelled for %@, Reason: a newer query came with before it",query);
        }
        
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Search text changed to : %@", searchText);
    modificationCount++;
    //[cities addObject:searchText];
    [self.citySearchTableView reloadData];
    if([searchText isEqual:@""]){
        cities = [[NSMutableArray alloc] init];
    } else {
        dispatch_async(dispatch_queue_create("com.anvaysri.cityPick", NULL), ^{
            [self triggerSearch:searchText withModificationCount:modificationCount];
            NSLog(@"Search completed for : %@", searchText);
        });
        //[self triggerSearch:searchText];
    }
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Table length right now is %lu",(unsigned long)[cities count]);
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CitiesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if(indexPath.row >= [cities count]){
        return cell;
    }
    NSString *name = [[cities objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSString *country = [[cities objectAtIndex:indexPath.row] valueForKey:@"countryName"];
    NSArray *displayTextArray = [[NSArray alloc] initWithObjects:name,country,nil];
    cell.textLabel.text = [displayTextArray componentsJoinedByString:@","];
    return cell;
}

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
    [ self.citySerchBar setDelegate:self];
    [self.citySerchBar becomeFirstResponder];
    UIBarButtonItem *backButton =[ [UIBarButtonItem alloc] initWithTitle:@"HeadTo" style:UIBarButtonItemStylePlain target:self action:@selector(goBack) ];
    self.navigationItem.leftBarButtonItem = backButton;
    cities = [ [NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

-(void) goBack
{
    [self.delegate setCity:@"Chennai"];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:NO];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
