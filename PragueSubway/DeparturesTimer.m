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
@property NSInteger departureIndex;

@end


@implementation DeparturesTimer


- (instancetype)initWithDepartures:(NSArray *)departures {
    if (self = [super init]) {
        self.sortedDeparures = [self sortByTimeDepartures:departures];
        self.departureIndex = 0;
    }
    return self;
}

- (Departure *)getDeparture {
    return nil;
}

- (NSString *)getRemainingTime {
    return @"";
}

- (void)start {
    double currentTime = [[NSDate date] timeIntervalSince1970];
    double differenceTime = -1;
    for (NSInteger i = 0; i < self.sortedDeparures.count; i++) {
        Departure *departure = self.sortedDeparures[i];
        double departureDifferenceTime = departure.time - currentTime;
        if (departureDifferenceTime >= 0 && departureDifferenceTime < differenceTime) {
            self.differenceTime = departureDifferenceTime;
            self.departureIndex = i;
            
        }
    }
}

#pragma mark - Private methods

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
