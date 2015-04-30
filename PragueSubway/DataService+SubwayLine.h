//
//  DataService+SubwayLine.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 21/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService.h"

@class SubwayLine;

@interface DataService (SubwayLine)

- (SubwayLine *)createSubwayLineWithDict:(NSDictionary *)data;
- (SubwayLine *)subwayLineWithName:(NSString *)name;
- (NSArray *)subwayLineArray;
- (NSArray *)subwayLineArraySorted;

@end
