//
//  DeparturesTimer.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Departure;

@interface DeparturesTimer : NSObject

- (instancetype)initWithDepartures:(NSArray *)departures;
- (Departure *)getDeparture;
- (NSString *)getRemainingTime;
- (void)start;

@end
