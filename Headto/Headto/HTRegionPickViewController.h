//
//  HTRegionPickViewController.h
//  Headto
//
//  Created by Anvay Srivastava on 13/12/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTRegionElement.h"
#import "HTRegionPickViewController.h"

@protocol HTViewControllerRegionPropertyProtocol
- (void) setRegion:(HTRegionElement *)destinationRegion;
@end

@interface HTRegionPickViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property HTRegionElement *selectedRegion;
@property (weak,nonatomic) id<HTViewControllerRegionPropertyProtocol> delegate;


@end
