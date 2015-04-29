//
//  StationViewController.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 29/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Station;

@protocol StationViewDelegate <NSObject>

- (void)stationViewDidDismiss;

@end

@interface StationViewController : UIViewController

@property (nonatomic, weak) Station* station;
@property (nonatomic, assign) id<StationViewDelegate> delegate;

@end
