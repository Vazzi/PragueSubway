//
//  DataService+InitialData.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 21/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService+InitialData.h"
#import "DataService+SubwayLine.h"
#import "DataService+Station.h"

#import <UIKit/UIKit.h>

@implementation DataService (InitialData)

static const CGFloat sideSize = 1000;

- (void)createAndSaveInitialData {
    
    // Do nothing if there are already some data
    if ([[self subwayLineArray] count] > 0) {
        return;
    }
    
    NSDictionary *lines = [self createInitialSubwayLines];
}

- (NSDictionary *)createInitialSubwayLines {
    NSArray *subwayLinesDict = [self SubwayLinesData];
    
    SubwayLine *lineA = [self createSubwayLineWithDict:subwayLinesDict[0]];
    SubwayLine *lineB = [self createSubwayLineWithDict:subwayLinesDict[1]];
    SubwayLine *lineC = [self createSubwayLineWithDict:subwayLinesDict[2]];
    
    return @{@"A":lineA,
             @"B":lineB,
             @"C":lineC};
}

- (NSArray *)SubwayLinesData {
    return @[@{@"name": @"A", @"color": [UIColor colorWithRed: 0.161 green: 0.694 blue: 0.235 alpha: 1]},
             @{@"name": @"B", @"color": [UIColor colorWithRed: 0.988 green: 0.745 blue: 0.125 alpha: 1]},
             @{@"name": @"C", @"color": [UIColor colorWithRed: 0.98 green: 0.0667 blue: 0 alpha: 1]}];
}

- (NSArray *)lineAStations {
    return @[@{@"name": @"Nemocnice Motol", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Petřiny", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Nádraží Veleslavín", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Bořislavka", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Dejvická", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Hradčany", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Malostranská", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Staroměstská", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Můstek", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Muzeum", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Náměstí Míru", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Jiřího z Poděbrad", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Flora", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Želivského", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Strašnická", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Skalka", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Depo Hostivař", @"latitude": @0.0, @"longitude": @0.0}];
    
}

@end
