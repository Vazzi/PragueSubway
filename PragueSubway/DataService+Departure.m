//
//  DataService+Departure.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 21/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService+Departure.h"
#import "Departure.h"

@implementation DataService (Departure)

- (Departure *)createDepartureWithDict:(NSDictionary *)data {
    NSString *entityString = [[Departure class] description];
    Departure *record = [NSEntityDescription insertNewObjectForEntityForName:entityString inManagedObjectContext:self.managedObjectContext];
    [record setValuesForKeysWithDictionary:data];
    return record;
}

- (NSArray *)departuresArray {
    NSString *entityString = [[Departure class] description];
    return [self recordsIn:entityString predicate:nil];
}


@end
