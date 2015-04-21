//
//  DataService+InitialData.m
//  PragueSubway
//
//  Created by Jakub Vlasák on 21/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import "DataService+InitialData.h"
#import "DataService+SubwayLine.h"

#import <UIKit/UIKit.h>

@implementation DataService (InitialData)

- (void)createAndSaveInitialData {
    // Do nothing if there are already some data
    if ([[self subwayLineArray] count] > 0) {
        return;
    }
    
    NSArray *subwayLines = [self createInitialSubwayLines];
    [subwayLines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self createSubwayLineWithDict:obj];
    }];
}

- (NSArray *)createInitialSubwayLines {
    return @[@{@"name": @"A", @"color": [UIColor colorWithRed: 0.161 green: 0.694 blue: 0.235 alpha: 1]},
             @{@"name": @"B", @"color": [UIColor colorWithRed: 0.988 green: 0.745 blue: 0.125 alpha: 1]},
             @{@"name": @"C", @"color": [UIColor colorWithRed: 0.98 green: 0.0667 blue: 0 alpha: 1]}];
}

@end
