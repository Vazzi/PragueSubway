//
//  StationLocationManager.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 05/05/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Station;

@protocol StationLocationDelegate <NSObject>

- (void)stationFound:(Station *)station;

@end

@interface StationLocationManager : NSObject

@property (nonatomic, assign) id<StationLocationDelegate> delegate;

- (instancetype)init;
- (void)startUpdatingLocation;
- (Station *)getNearestStation;
- (void)showAllertIfServiceDisabled;
- (BOOL)isServiceDisabled;

@end
