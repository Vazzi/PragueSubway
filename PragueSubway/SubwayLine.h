//
//  SubwayLine.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Station;

@interface SubwayLine : NSManagedObject

@property (nonatomic, retain) id color;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *stations;
@end

@interface SubwayLine (CoreDataGeneratedAccessors)

- (void)insertObject:(Station *)value inStationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStationsAtIndex:(NSUInteger)idx;
- (void)insertStations:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStationsAtIndex:(NSUInteger)idx withObject:(Station *)value;
- (void)replaceStationsAtIndexes:(NSIndexSet *)indexes withStations:(NSArray *)values;
- (void)addStationsObject:(Station *)value;
- (void)removeStationsObject:(Station *)value;
- (void)addStations:(NSOrderedSet *)values;
- (void)removeStations:(NSOrderedSet *)values;
@end
