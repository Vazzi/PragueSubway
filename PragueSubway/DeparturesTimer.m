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
    [self updateIndex];
    return self.sortedDeparures[self.departureIndex];
}

- (NSString *)getFormatedRemainingTime {
    NSDate *remainingTime = [self getRemainingTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate:remainingTime];
    return resultString;
    
}

- (void)start {
    double currentTime = [self getCurrentTime];
    double differenceTime = -1;
    for (NSInteger i = 0; i < self.sortedDeparures.count; i++) {
        Departure *departure = self.sortedDeparures[i];
        double departureDifferenceTime = departure.time - currentTime;
        if (departureDifferenceTime >= 0 && departureDifferenceTime < differenceTime) {
            differenceTime = departureDifferenceTime;
            self.departureIndex = i;
            
        }
    }
}

#pragma mark - Private methods

- (void)updateIndex {
    double currentTime = [self getCurrentTime];
    for (NSInteger i = self.departureIndex; YES; i = (i+1) % self.sortedDeparures.count) {
        Departure *departure = self.sortedDeparures[i];
        if ((currentTime - departure.time) >= 0) {
            self.departureIndex = i;
            break;
        }
    }
}

- (double)getCurrentTime {
    NSDate *today = [self resetTimeForDate:[NSDate date]];
    return [[NSDate date] timeIntervalSinceDate:today];
}
                     
- (NSDate*)resetTimeForDate:(NSDate*)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                fromDate:date];
    [components setTimeZone:[NSTimeZone defaultTimeZone]];
    NSDate *clearedDate = [[NSCalendar currentCalendar] dateFromComponents:components];

    return clearedDate;
}

- (NSDate *)getRemainingTime {
    [self updateIndex];
    double currentTime = [self getCurrentTime];
    Departure *departure = self.sortedDeparures[self.departureIndex];
    NSDate *remainingTime = [NSDate dateWithTimeIntervalSinceNow:(departure.time - currentTime)];
    return remainingTime;
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
