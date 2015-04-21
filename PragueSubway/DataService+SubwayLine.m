//
//  DataService+SubwayLine.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 21/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService+SubwayLine.h"
#import "SubwayLine.h"

@implementation DataService (SubwayLine)

-(SubwayLine *)createSubwayLineWithDict:(NSDictionary *)data {
    NSString *entityString = [[SubwayLine class] description];
    SubwayLine *record = [NSEntityDescription insertNewObjectForEntityForName:entityString inManagedObjectContext:self.managedObjectContext];
    [record setValuesForKeysWithDictionary:data];
    return record;
}

-(NSArray *)subwayLineArray {
    NSString *entityString = [[SubwayLine class] description];
    return [self recordsIn:entityString predicate:nil];
}

@end
