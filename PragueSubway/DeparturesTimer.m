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
    [self updateIndexAndGetDifference];
    return self.sortedDeparures[self.departureIndex];
}

- (NSString *)getFormatedRemainingTime {
    NSTimeInterval remainingSeconds = [self updateIndexAndGetDifference];
    return [self stringFromTimeInterval:remainingSeconds];
    
}

- (void)start {
    NSTimeInterval currentTime = [self getCurrentTime];
    NSTimeInterval differenceTime = ((Departure *)self.sortedDeparures[0]).time;
    for (NSInteger i = 0; i < self.sortedDeparures.count; i++) {
        Departure *departure = self.sortedDeparures[i];
        NSTimeInterval departureDifferenceTime = departure.time - currentTime;
        if (departureDifferenceTime >= 0 && departureDifferenceTime < differenceTime) {
            differenceTime = departureDifferenceTime;
            self.departureIndex = i;
            
        }
    }
}

#pragma mark - Private methods

- (NSTimeInterval)updateIndexAndGetDifference {
    NSTimeInterval currentTime = [self getCurrentTime];
    NSTimeInterval diff = -1;
    NSInteger i = self.departureIndex;
    
    for (i = self.departureIndex; YES; i = fmodf((i+1), self.sortedDeparures.count)) {
        Departure *departure = self.sortedDeparures[i];
        diff = (departure.time - currentTime);
        if (diff > 0) break;
    }
    self.departureIndex = i;
    return diff;
}

- (NSTimeInterval)getCurrentTime {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *today = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:[NSDate date] options:0];
    return [[NSDate date] timeIntervalSinceDate:today];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    if (hours == 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    }
    return [NSString stringWithFormat:@"%01ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
}

- (NSArray *)sortByTimeDepartures:(NSArray *)departures {
    NSArray *sortedArray;
    sortedArray = [departures sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        double first = [(Departure *)a time];
        double second = [(Departure *)b time];
        return first > second;
    }];
    return sortedArray;
}


@end
