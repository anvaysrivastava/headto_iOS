//
//  HTViewController.m
//  Headto
//
//  Created by Anvay Srivastava on 08/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import "HTViewController.h"
#import "HTPlacePickViewController.h"

@interface HTViewController ()

@property (weak,nonatomic) UIStoryboard *storyBoard;

@end

@implementation HTViewController

@synthesize placePickTextField=_placePickTextField;

-(void) setPlace:(NSString *)place
{
    [ [self placePickTextField] setText:place];
}

- (IBAction)openPlacePickView:(id)sender
{
    NSLog(@"Place pick event has been triggered");
    
    //[self performSegueWithIdentifier:@"placePickSegue" sender:self];
    [ self.placePickTextField resignFirstResponder ];
    HTPlacePickViewController *placePickViewController = (HTPlacePickViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"HTPlacePickViewController"];
    placePickViewController.delegate = self;
    [ [self navigationController] setNavigationBarHidden:NO];
    [[self navigationController] pushViewController:placePickViewController animated:NO];
    NSLog(@"open place pick completed");
    //[self presentViewController:placePickViewController animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
