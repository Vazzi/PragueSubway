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

static const CGFloat sideSize = 500;

- (void)createAndSaveInitialData {
    
    // Do nothing if there are already some data
    if ([[self subwayLineArray] count] > 0) {
        return;
    }
    
    NSArray *subwayLinesDict = [self createInitialSubwayLines];
    NSMutableArray *subwayLines = [[NSMutableArray alloc] init];
    for (NSDictionary *lineDict in subwayLinesDict) {
        SubwayLine *line = [self createSubwayLineWithDict:lineDict];
        [subwayLines addObject:line];
    }
    
    NSArray *stations = [self createInitialStationsWithLines:subwayLines];
    for (NSDictionary *station in stations) {
        [self createStationWithDict:station];
    }
    
}

- (NSArray *)createInitialSubwayLines {
    return @[@{@"name": @"A", @"color": [UIColor colorWithRed: 0.161 green: 0.694 blue: 0.235 alpha: 1]},
             @{@"name": @"B", @"color": [UIColor colorWithRed: 0.988 green: 0.745 blue: 0.125 alpha: 1]},
             @{@"name": @"C", @"color": [UIColor colorWithRed: 0.98 green: 0.0667 blue: 0 alpha: 1]}];
}

- (NSArray *)createInitialStationsWithLines:(NSArray *)subwayLines {
    
    
    NSArray *lineA = @[@{@"name": @"Nemocnice Motol", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Petřiny", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Nádraží Veleslavín", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Bořislavka", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Dejvická", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Hradčany", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Malostranská", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Staroměstská", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Můstek", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Muzeum", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Náměstí Míru", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Jiřího z Poděbrad", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Flora", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Želivského", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Strašnická", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Skalka", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       @{@"name": @"Depo Hostivař", @"drawPosX": @0.0, @"drawPosY": @0.0, @"latitude": @0.0, @"longitude": @0.0, @"line": subwayLines[0]},
                       ];
    
    CGFloat yOffset = 40;
    CGFloat xOffset = 20;
    CGFloat xStep = sideSize / 8;
    
    for (int i = 0; i < lineA.count; i++) {
        if (i == 9) {
            xOffset += 40;
            lineA[i][@"drawPosX"] = [NSNumber numberWithFloat:xOffset];
            lineA[i][@"drawPosY"] = [NSNumber numberWithFloat:yOffset + 40];
        } else if (i == 10) {
            xOffset += 40;
            lineA[i][@"drawPosX"] = [NSNumber numberWithFloat:xOffset];
            lineA[i][@"drawPosY"] = [NSNumber numberWithFloat:yOffset + 40];
            xOffset += 40;
            xStep = sideSize / 7;
        } else {
            lineA[i][@"drawPosX"] = [NSNumber numberWithFloat:xOffset];
            lineA[i][@"drawPosY"] = [NSNumber numberWithFloat:yOffset];
            xOffset += xStep;
        }
    }
    
    return lineA;
}


@end
