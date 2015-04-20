//
//  DataService+Station.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 20/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import  "DataService.h"

@class Station;

@interface DataService (Station)

- (Station *)createStationWithDict:(NSDictionary *)data;
- (NSArray *)stationsArray;

@end
