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
NSMutableData *responseData;
NSURLConnection *connection;
NSString *searchResponse;
bool isSearchTriggered;
@synthesize delegate;
@synthesize citySearchTableView=_citySearchTableView;


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
    NSLog(@"Recived response %@",responseData);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    searchResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *error = [ [NSError alloc] init];
    NSObject *o =[NSJSONSerialization JSONObjectWithData:responseData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&error];
    NSLog(@"Parsed json is %@",o);
    NSLog(@"Error message is %@",error);
    NSLog(@"The search json was %@",searchResponse);
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void) triggerSearch:(NSString *)query
{
    if( !isSearchTriggered){
        isSearchTriggered= true;
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
            isSearchTriggered = false;
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
            cities = [responseJSON valueForKey:@"geonames"];
        }
        isSearchTriggered = false;
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"Search text changed to : %@", searchText);
    //[cities addObject:searchText];
    [self.citySearchTableView reloadData];
    if([searchText isEqual:@""]){
        cities = [[NSMutableArray alloc] init];
    } else {
        [self triggerSearch:searchText];
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
