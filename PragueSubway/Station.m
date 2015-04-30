//
//  Station.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "Station.h"
#import "Departure.h"
#import "SubwayLine.h"


@implementation Station

@dynamic drawPosX;
@dynamic drawPosY;
@dynamic latitude;
@dynamic longitude;
@dynamic name;
@dynamic departures;
@dynamic departuresDirectStation;
@dynamic line;

- (CGPoint)getDrawPoint {
    return CGPointMake(self.drawPosX, self.drawPosY);
}

- (bool)isEndStation {
    Station *first = [self getFirstLine].stations.firstObject;
    Station *last =  [self getFirstLine].stations.lastObject;
    if ([first isEqual:self]) {
        return true;
    }
    if ([last isEqual:self]) {
        return true;
    }
    return false;
}

- (bool)isTransferStation {
    return (self.line.count > 1);
}

- (SubwayLine *)getFirstLine {
    return (SubwayLine *)self.line.firstObject;
}

- (void)addLineObject:(SubwayLine *)value {
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.line];
    [tempSet addObject:value];
    self.line = tempSet;
}

- (NSInteger)getNumberOfDirections {
    if ([self isEndStation]) {
        return 1;
    } else if ([self isTransferStation]) {
        return self.line.count * 2;
    }
    return 2;
}

- (NSArray *)getAllDeparturesGroupedByDirections {
    NSMutableArray *departuresArray = [[NSMutableArray alloc] init];
    
    NSArray *directionsStations = [self getDirectionStations];
    for (Station *station in directionsStations) {
        [departuresArray addObject:[self getAllDeparturesForDirections:station]];
    }
    
    return [NSArray arrayWithArray:departuresArray];
}

- (NSArray *)getDeparturesGroupedByDirectionsForLine:(SubwayLine *)line {
    NSMutableArray *departuresArray = [[NSMutableArray alloc] init];
    
    NSArray *directionsStations = [self getDirectionStationsForLine:line];
    for (Station *station in directionsStations) {
        [departuresArray addObject:[self getAllDeparturesForDirections:station]];
    }
    
    return [NSArray arrayWithArray:departuresArray];
	
}


#pragma mark - Private methods

- (NSArray *)getDirectionStations {
    return [self getDirectionStationsForLine:nil];
}

- (NSArray *)getDirectionStationsForLine:(SubwayLine  *)subwayLine {
    NSMutableArray *directionsStations = [[NSMutableArray alloc] init];
    NSArray *lines = [self.line  array];
    for (SubwayLine *line in lines) {
        if (![line isEqual:subwayLine]) {
            continue;
        }
        if (line.stations.firstObject != self) {
            [directionsStations addObject:line.stations.firstObject];
        }
        if (line.stations.lastObject != self) {
            [directionsStations addObject:line.stations.lastObject];
        }
    }
    
    return [NSArray arrayWithArray:directionsStations];
}

- (NSSet *)getAllDeparturesForDirections:(Station *)station {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"directionStation.name == %@", station.name];
    return [self.departures filteredSetUsingPredicate:predicate];
}

@end
