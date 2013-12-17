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
#import "HTRegionElement.h"
#import "HTRegionPickViewController.h"


@interface HTViewController : UIViewController <HTViewControllerRegionPropertyProtocol>
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;

@end
