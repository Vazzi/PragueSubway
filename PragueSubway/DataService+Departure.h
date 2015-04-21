//
//  DataService+Departure.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 21/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService.h"

@class Departure;

@interface DataService (Departure)

- (Departure *)createDepartureWithDict:(NSDictionary *)data;
- (NSArray *)departuresArray;

@end
