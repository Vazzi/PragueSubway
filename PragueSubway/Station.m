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

- (CGPoint)getdrawPoint {
    return CGPointMake(self.drawPosX, self.drawPosX);
}

@end
