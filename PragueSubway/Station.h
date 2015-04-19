//
//  Station.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Station : NSManagedObject

@property (nonatomic, retain) NSNumber * drawPosX;
@property (nonatomic, retain) NSNumber * drawPosY;
@property (nonatomic, retain) NSDecimalNumber * latitude;
@property (nonatomic, retain) NSDecimalNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *departures;
@property (nonatomic, retain) NSSet *departuresDirectStation;
@property (nonatomic, retain) NSOrderedSet *line;
@end

@interface Station (CoreDataGeneratedAccessors)

- (void)addDeparturesObject:(NSManagedObject *)value;
- (void)removeDeparturesObject:(NSManagedObject *)value;
- (void)addDepartures:(NSSet *)values;
- (void)removeDepartures:(NSSet *)values;

- (void)addDeparturesDirectStationObject:(NSManagedObject *)value;
- (void)removeDeparturesDirectStationObject:(NSManagedObject *)value;
- (void)addDeparturesDirectStation:(NSSet *)values;
- (void)removeDeparturesDirectStation:(NSSet *)values;

- (void)insertObject:(NSManagedObject *)value inLineAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLineAtIndex:(NSUInteger)idx;
- (void)insertLine:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLineAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLineAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceLineAtIndexes:(NSIndexSet *)indexes withLine:(NSArray *)values;
- (void)addLineObject:(NSManagedObject *)value;
- (void)removeLineObject:(NSManagedObject *)value;
- (void)addLine:(NSOrderedSet *)values;
- (void)removeLine:(NSOrderedSet *)values;
@end
