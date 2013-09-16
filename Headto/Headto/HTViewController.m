//
//  HTViewController.m
//  Headto
//
//  Created by Anvay Srivastava on 08/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import "HTViewController.h"
#import "HTPlacePickViewController.h"
#import "HTCityPickViewController.h"

@interface HTViewController ()

@property (weak,nonatomic) UIStoryboard *storyBoard;

@end

@implementation HTViewController

@synthesize placePickTextField=_placePickTextField;
@synthesize cityLabel=_cityLabel;

-(void) setPlace:(NSString *)place
{
    [ [self placePickTextField] setText:place];
}

-(void) setCity:(NSString *)city
{
    [ [self cityLabel] setText:city];
}

- (IBAction)openPlacePickView:(id)sender
{
    
    [ self.placePickTextField resignFirstResponder ];
    HTPlacePickViewController *placePickViewController = (HTPlacePickViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HTPlacePickViewController"];
    placePickViewController.delegate = self;
    [ [self navigationController] setNavigationBarHidden:NO];
    [ [self navigationController] pushViewController:placePickViewController animated:NO];
    
}

- (IBAction)openCityPickView:(id)sender
{
    HTCityPickViewController *cityPickViewController = (HTCityPickViewController *)[ self.storyboard instantiateViewControllerWithIdentifier:@"HTCityPickViewController"];
    cityPickViewController.delegate = self;
    [ [self navigationController] setNavigationBarHidden:NO];
    [ [self navigationController] pushViewController:cityPickViewController  animated:NO];
}

-(void)testJSONConversion
{
    NSString *jsonString = @"{\"a\":\"b\"}";
    
    NSError *e = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                                               options: NSJSONReadingMutableContainers
                                                                 error: &e];
    //[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"NSJson is %@",[jsonObject valueForKey:@"a"]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testJSONConversion];
    self.storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil ];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    NSLog(@"view did load");
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
