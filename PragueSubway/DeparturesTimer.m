//
//  DeparturesTimer.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 30/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DeparturesTimer.h"
#import "Departure.h"

@interface DeparturesTimer ()

@property (strong, nonatomic) NSArray *sortedDeparures;

@end


@implementation DeparturesTimer


- (instancetype)initWithDepartures:(NSArray *)departures {
    if (self = [super init]) {
        self.sortedDeparures = [self sortByTimeDepartures:departures];
    }
    return self;
}

- (Departure *)getDeparture {
    return nil;
}

- (NSString *)getRemainingTime {
    return @"";
}

- (NSArray *)sortByTimeDepartures:(NSArray *)departures {
    NSArray *sortedArray;
    sortedArray = [departures sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        double first = [(Departure *)a time];
        double second = [(Departure *)b time];
        return first < second;
    }];
    return sortedArray;
}

@end
