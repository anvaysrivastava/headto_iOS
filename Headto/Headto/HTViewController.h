//
//  HTViewController.h
//  Headto
//
//  Created by Anvay Srivastava on 08/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTPlacePickViewController.h"

@interface HTViewController : UIViewController <PlacePickRootViewContollerDelegage>

@property (weak, nonatomic) IBOutlet UITextField *placePickTextField;

- (IBAction)openPlacePickView:(id)sender;

@end
