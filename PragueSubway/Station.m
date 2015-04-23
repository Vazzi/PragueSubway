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


@end
