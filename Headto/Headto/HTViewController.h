//
//  HTViewController.h
//  Headto
//
//  Created by Anvay Srivastava on 08/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTPlacePickViewController.h"
#import "HTCityPickViewController.h"

@interface HTViewController : UIViewController <PlacePickRootViewContollerDelegage, CityPickRootViewController>
@property (weak, nonatomic) IBOutlet UITextField *placePickTextField;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;


- (IBAction)openPlacePickView:(id)sender;
- (IBAction)openCityPickView:(id)sender;

@end
