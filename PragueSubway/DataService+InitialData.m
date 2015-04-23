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
    double time = 4*60 + 40;
    double endTime = 23*60 + 50;
    
    while(time < endTime) {
        Departure *departure = [[DataService sharedService] createDepartureWithDict:nil];
        departure.time = time;
        departure.station = station;
        departure.directionStation = toStation;
        departure.day = @"W";
        
        time += 3 + rand() % (10-3);
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
    return @{@"left" : @[@{@"name": @"Zličín", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Stodůlky", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Luka", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Lužiny", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Hůrka", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Nové Butovice", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Jinonice", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Radlická", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Smíchovské nádraží", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Anděl", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Karlovo náměstí", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Národní třída", @"latitude": @0.0, @"longitude": @0.0}],
             @"right" : @[@{@"name": @"Křižíkova", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Invalidovna", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Palmovka", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Českomoravská", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Vysočanská", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Kolbenova", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Hloubětín", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Rajská zahrada", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Černý most", @"latitude": @0.0, @"longitude": @0.0}]
             
             };
};

- (NSDictionary *)lineCStations {
    return @{@"left" : @[@{@"name": @"Háje", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Opatov", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Chodov", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Roztyly", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Kačerov", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Budějovická", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Pankrác", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Pražského povstání", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"Vyšehrad", @"latitude": @0.0, @"longitude": @0.0},
                         @{@"name": @"I.P. Pavlova", @"latitude": @0.0, @"longitude": @0.0}],
             @"right" : @[@{@"name": @"Vltavská", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Nádraží Holešovice", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Kobylisy", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Ládví", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Střížkov", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Prosek", @"latitude": @0.0, @"longitude": @0.0},
                          @{@"name": @"Letňany", @"latitude": @0.0, @"longitude": @0.0}]
             
             };
};

- (NSArray *)middleStations {
    return @[@{@"name": @"Můstek", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Muzeum", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Hlavní nádraží", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Náměstí Republiky", @"latitude": @0.0, @"longitude": @0.0},
             @{@"name": @"Florenc", @"latitude": @0.0, @"longitude": @0.0},
             ];
}


@end
