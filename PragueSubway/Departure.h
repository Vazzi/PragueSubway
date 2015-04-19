//
//  Departure.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Station;

@interface Departure : NSManagedObject

@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) Station *directionStation;
@property (nonatomic, retain) Station *station;

@end
