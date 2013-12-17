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
#import "HTRegionElement.h"
#import "HTRegionPickViewController.h"

@interface HTViewController ()

@property HTRegionElement *destinationRegion;

@end

@implementation HTViewController

-(void) setRegion:(HTRegionElement *)destinationRegion
{
    NSLog(@"setRegion method has been called in HTViewController");
    self.destinationRegion = destinationRegion;
    self.regionLabel.text = destinationRegion.regionName;
    NSLog(@"destinationRegion has been changed to %@ in HTViewController",self.destinationRegion.regionName);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destinationViewController = [segue destinationViewController];
    NSLog(@"DestinationViewController class is %@",destinationViewController.class);
    if([destinationViewController isKindOfClass:[HTRegionPickViewController class]])
    {
        HTRegionPickViewController *regionPickViewController = (HTRegionPickViewController *) destinationViewController;
        regionPickViewController.delegate = self;
    }
}


- (IBAction)unwindToMainView:(UIStoryboardSegue *)segue
{
    NSObject *inputViewController = [segue sourceViewController];
    if([inputViewController isKindOfClass:[HTRegionPickViewController class]] )
    {
        HTRegionPickViewController *newRegionPickViewController = (HTRegionPickViewController *)inputViewController;
        if(newRegionPickViewController.selectedRegion !=NULL ){
            self.destinationRegion = newRegionPickViewController.selectedRegion;
            self.regionLabel.text = self.destinationRegion.regionName;
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.destinationRegion = [[HTRegionElement alloc] init];
    self.destinationRegion.regionName = @"Bangalore";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
