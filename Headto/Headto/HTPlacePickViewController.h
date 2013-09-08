//
//  HTPlacePickViewController.h
//  Headto
//
//  Created by Anvay Srivastava on 08/09/13.
//  Copyright (c) 2013 Anvay Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlacePickRootViewContollerDelegage <NSObject>
- (void)setPlace:(NSString *)place;
@end

@interface HTPlacePickViewController : UIViewController
@property (assign) id<PlacePickRootViewContollerDelegage> delegate;

@end
