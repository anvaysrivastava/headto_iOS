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

@synthesize delegate;

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
