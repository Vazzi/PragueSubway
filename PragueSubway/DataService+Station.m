//
//  DataService+Station.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 20/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService+Station.h"

#import "Station.h"

@implementation DataService (Station)

-(Station *)createStationWithDict:(NSDictionary *)data {
    NSString *entityString = [[Station class] description];
    Station *record = [NSEntityDescription insertNewObjectForEntityForName:entityString inManagedObjectContext:self.managedObjectContext];
    [record setValuesForKeysWithDictionary:data];
    return record;
}

-(NSArray *)stationsArray {
    NSString *entityString = [[Station class] description];
    return [self recordsIn:entityString predicate:nil];
}

@end
