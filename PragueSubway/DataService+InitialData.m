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
#import "DataService+Departure.h"

#import "Station.h"
#import "Departure.h"
#import "SubwayLine.h"

#import <UIKit/UIKit.h>

@implementation DataService (InitialData)

#pragma mark - Create data

- (void)createAndSaveInitialData {
    
    // Do nothing if there are already some data
    if ([[self subwayLineArray] count] > 0) {
        return;
    }
    
    NSDictionary *linesDict = [self createInitialSubwayLines];
    [self createInitialStationsWithLines:linesDict];
    [self createDeparturesForAllStations];
    
}

#pragma mark Create subway lines

- (NSDictionary *)createInitialSubwayLines {
    NSArray *subwayLinesDict = [self SubwayLinesData];
    
    SubwayLine *lineA = [self createSubwayLineWithDict:subwayLinesDict[0]];
    SubwayLine *lineB = [self createSubwayLineWithDict:subwayLinesDict[1]];
    SubwayLine *lineC = [self createSubwayLineWithDict:subwayLinesDict[2]];
    
    return @{@"A":lineA,
             @"B":lineB,
             @"C":lineC};
}

#pragma mark Create stations

- (void)createInitialStationsWithLines:(NSDictionary *)subwayLines {
   
    NSDictionary *stationsA = [self lineAStations];
    NSDictionary *stationsB = [self lineBStations];
    NSDictionary *stationsC = [self lineCStations];
    
    // Left side stations
    CGFloat x = DRAW_INSETS_SIDE;
    [self createStations:stationsA[@"left"] withLine:subwayLines[@"A"] onYPosition:0 leftX:x];
    [self createStations:stationsB[@"left"] withLine:subwayLines[@"B"] onYPosition:2 leftX:x];
    [self createStations:stationsC[@"left"] withLine:subwayLines[@"C"] onYPosition:4 leftX:x];

    // Middle stations
    [self createMiddleStationsWithLines:subwayLines];

    // Right side stations
    x = DRAW_INSETS_SIDE + DRAW_SIDE_STATIONS_SIZE + 2 * DRAW_MIDDLE_INSETS_SIDE + DRAW_MIDDLE_STATIONS_SIZE;
    [self createStations:stationsA[@"right"] withLine:subwayLines[@"A"] onYPosition:4 leftX:x];
    [self createStations:stationsB[@"right"] withLine:subwayLines[@"B"] onYPosition:2 leftX:x];
    [self createStations:stationsC[@"right"] withLine:subwayLines[@"C"] onYPosition:0 leftX:x];

}

- (void)createStations:(NSDictionary *) stations
              withLine:(SubwayLine *)line
               onYPosition:(int) position
                 leftX:(CGFloat) x {
    
    CGFloat yOffset = [self getYForLine:position];
    CGFloat xOffset = x;
    CGFloat xStep = DRAW_SIDE_STATIONS_SIZE / (stations.count - 1);
    
    for (NSDictionary *dict in stations) {
        Station *station = [[DataService sharedService] createStationWithDict:dict];
        station.drawPosX = xOffset;
        station.drawPosY = yOffset;
        [station addLineObject:line];

        xOffset += xStep;
    }
}

- (void)createMiddleStationsWithLines:(NSDictionary *)line {
    
    NSArray *stationsDict = [self middleStations];
    
    for (NSDictionary *dict in stationsDict) {
        Station *station = [[DataService sharedService] createStationWithDict:dict];
        if ([station.name isEqualToString:@"Můstek"]) {
            station.drawPosX = [self getMiddleXPosition:0];
            station.drawPosY = [self getYForLine:1];
            [station addLineObject:line[@"A"]];
            [station addLineObject:line[@"B"]];
        } else if ([station.name isEqualToString:@"Muzeum"]) {
            station.drawPosX = [self getMiddleXPosition:1];
            station.drawPosY = [self getYForLine:3];
            [station addLineObject:line[@"C"]];
            [station addLineObject:line[@"A"]];
        } else if ([station.name isEqualToString:@"Hlavní nádraží"]) {
            station.drawPosX = [self getMiddleXPosition:1.5];
            station.drawPosY = [self getYForLine:2];
            [station addLineObject:line[@"C"]];
        } else if ([station.name isEqualToString:@"Florenc"]) {
            station.drawPosX = [self getMiddleXPosition:2];
            station.drawPosY = [self getYForLine:1];
            [station addLineObject:line[@"C"]];
            [station addLineObject:line[@"B"]];
        } else if ([station.name isEqualToString:@"Náměstí Republiky"]) {
            station.drawPosX = [self getMiddleXPosition:1];
            station.drawPosY = [self getYForLine:0];
            [station addLineObject:line[@"B"]];
        }
    }
    
}

#pragma mark Create departures

- (void)createDeparturesForAllStations {
    NSArray *subwayLines = [[DataService sharedService] subwayLineArray];
    
    for (SubwayLine *line in subwayLines) {
        for (Station *station in line.stations) {
            if (![station isEqual:line.stations.lastObject]) {
                [self generateDeparturesForStation:station toStation:line.stations.lastObject];
            }
            if (![station isEqual:line.stations.firstObject]) {
                [self generateDeparturesForStation:station toStation:line.stations.firstObject];
            }
        }
    }
}

- (void)generateDeparturesForStation:(Station *)station toStation:(Station *)toStation {
    double time = 4*60*60 + 40*60 + 60 ;
    double endTime = 23*60*60 + 50*60 + 60;
    
    while(time < endTime) {
        Departure *departure = [[DataService sharedService] createDepartureWithDict:nil];
        departure.time = time;
        departure.station = station;
        departure.directionStation = toStation;
        departure.day = @"W";
        
        time += (3 + rand() % (10-3)) * 60;
    }
}

#pragma mark - Coordinates

- (CGFloat)getYForLine:(int) line {
    return DRAW_INSETS_TOP + (line * DRAW_Y_STEP);
}

- (CGFloat)getMiddleXPosition:(float) position {
    CGFloat xMiddleStep = DRAW_MIDDLE_STATIONS_SIZE / 2;
    CGFloat left = DRAW_INSETS_SIDE + DRAW_SIDE_STATIONS_SIZE + DRAW_MIDDLE_INSETS_SIDE;
    return left + (xMiddleStep * position);
}

#pragma mark - Data

#pragma mark Subway lines

- (NSArray *)SubwayLinesData {
    return @[@{@"name": @"A", @"color": [UIColor colorWithRed: 0.161 green: 0.694 blue: 0.235 alpha: 1]},
             @{@"name": @"B", @"color": [UIColor colorWithRed: 0.988 green: 0.745 blue: 0.125 alpha: 1]},
             @{@"name": @"C", @"color": [UIColor colorWithRed: 0.98 green: 0.0667 blue: 0 alpha: 1]}];
}
#pragma mark Stations

- (NSDictionary *)lineAStations {
    return @{@"left" : @[@{@"name": @"Nemocnice Motol", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Petřiny", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Nádraží Veleslavín", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Bořislavka", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Dejvická", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Hradčany", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Malostranská", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Staroměstská", @"latitude": @0.0, @"longitude": @0.0}],
             @"right" : @[@{@"name": @"Náměstí Míru", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Jiřího z Poděbrad", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Flora", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Želivského", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Strašnická", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Skalka", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Depo Hostivař", @"latitude": @0.0, @"longitude": @0.0}]
             
             };
};

- (NSDictionary *)lineBStations {
    return @{@"left" : @[@{@"name": @"Zličín", @"latitude": @50.054, @"longitude": @14.291},
                         @{@"name": @"Stodůlky", @"latitude": @50.046944, @"longitude": @14.306944},
                         @{@"name": @"Luka", @"latitude": @50.045556, @"longitude": @14.322222},
                         @{@"name": @"Lužiny", @"latitude": @50.045, @"longitude": @14.33},
                         @{@"name": @"Hůrka", @"latitude": @50.05, @"longitude": @14.343},
                         @{@"name": @"Nové Butovice", @"latitude": @50.051, @"longitude": @14.352},
                         @{@"name": @"Jinonice", @"latitude": @50.054444, @"longitude": @14.371111},
                         @{@"name": @"Radlická", @"latitude": @50.058, @"longitude": @14.389},
                         @{@"name": @"Smíchovské nádraží", @"latitude": @50.065, @"longitude": @14.408},
                         @{@"name": @"Anděl", @"latitude": @50.074, @"longitude": @14.405},
                         @{@"name": @"Karlovo náměstí", @"latitude": @50.076, @"longitude": @14.418},
                         @{@"name": @"Národní třída", @"latitude": @50.08, @"longitude": @14.42}],
             @"right" : @[@{@"name": @"Křižíkova", @"latitude": @50.0925, @"longitude": @14.451389},
                          @{@"name": @"Invalidovna", @"latitude": @50.096667, @"longitude": @14.463056},
                          @{@"name": @"Palmovka", @"latitude": @50.103889, @"longitude": @14.475},
                          @{@"name": @"Českomoravská", @"latitude": @50.106, @"longitude": @14.492},
                          @{@"name": @"Vysočanská", @"latitude": @50.111389, @"longitude": @14.501944},
                          @{@"name": @"Kolbenova", @"latitude": @50.110278, @"longitude": @14.513056},
                          @{@"name": @"Hloubětín", @"latitude": @50.106111, @"longitude": @14.538056},
                          @{@"name": @"Rajská zahrada", @"latitude": @50.106667, @"longitude": @14.560556},
                          @{@"name": @"Černý most", @"latitude": @50.109167, @"longitude": @14.5775}]
             };
};

- (NSDictionary *)lineCStations {
    return @{@"left" : @[@{@"name": @"Háje", @"latitude": @50.031, @"longitude": @14.527},
                         @{@"name": @"Opatov", @"latitude": @50.028, @"longitude": @14.508},
                         @{@"name": @"Chodov", @"latitude": @50.031, @"longitude": @14.491},
                         @{@"name": @"Roztyly", @"latitude": @50.037, @"longitude": @14.478},
                         @{@"name": @"Kačerov", @"latitude": @50.042, @"longitude": @14.46},
                         @{@"name": @"Budějovická", @"latitude": @50.044, @"longitude": @14.449},
                         @{@"name": @"Pankrác", @"latitude": @50.051, @"longitude": @14.439},
                         @{@"name": @"Pražského povstání", @"latitude": @50.056, @"longitude": @14.434},
                         @{@"name": @"Vyšehrad", @"latitude": @50.063, @"longitude": @14.431},
                         @{@"name": @"I.P. Pavlova", @"latitude": @50.075, @"longitude": @14.43}],
             @"right" : @[@{@"name": @"Vltavská", @"latitude": @50.099, @"longitude": @14.438},
                          @{@"name": @"Nádraží Holešovice", @"latitude": @50.11, @"longitude": @14.44},
                          @{@"name": @"Kobylisy", @"latitude": @50.123, @"longitude": @14.452},
                          @{@"name": @"Ládví", @"latitude": @50.127, @"longitude": @14.469},
                          @{@"name": @"Střížkov", @"latitude": @50.126, @"longitude": @14.489},
                          @{@"name": @"Prosek", @"latitude": @50.119, @"longitude": @14.499},
                          @{@"name": @"Letňany", @"latitude": @50.125, @"longitude": @14.514}]
             };

};

- (NSArray *)middleStations {
    return @[@{@"name": @"Můstek", @"latitude": @50.0842, @"longitude": @14.4233},
             @{@"name": @"Muzeum", @"latitude": @50.0796, @"longitude": @14.4312},
             @{@"name": @"Hlavní nádraží", @"latitude": @50.083, @"longitude": @14.436},
             @{@"name": @"Náměstí Republiky", @"latitude": @50.0883, @"longitude": @14.4318},
             @{@"name": @"Florenc", @"latitude": @50.091, @"longitude": @14.439},
             ];
}


@end
