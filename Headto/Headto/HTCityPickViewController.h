//
//  HTCityViewController.h
//  Headto
//
//  Created by Anvay Srivastava on 09/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityPickRootViewController <NSObject>

-(void) setCity:(NSString *)city;

@end

@interface HTCityPickViewController : UIViewController < UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (assign) id <CityPickRootViewController> delegate;
@property (nonatomic,weak) IBOutlet UITableView *citySearchTableView;
@property (nonatomic,weak) IBOutlet UISearchBar *citySerchBar;
@end
