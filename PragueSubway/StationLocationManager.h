//
//  StationLocationManager.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 05/05/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Station;

@interface StationLocationManager : NSObject

- (instancetype)init;
- (void)startUpdatingLocation;
- (Station *)getNearestStation;

@end
