//
//  Station.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class Departure, SubwayLine;

@interface Station : NSManagedObject

@property (nonatomic) float drawPosX;
@property (nonatomic) float drawPosY;
@property (nonatomic, retain) NSDecimalNumber * latitude;
@property (nonatomic, retain) NSDecimalNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *departures;
@property (nonatomic, retain) NSSet *departuresDirectStation;
@property (nonatomic, retain) NSOrderedSet *line;

- (CGPoint)getDrawPoint;
- (bool)isEndStation;
- (bool)isTransferStation;
- (SubwayLine *)getLine;

@end

@interface Station (CoreDataGeneratedAccessors)

- (void)addDeparturesObject:(Departure *)value;
- (void)removeDeparturesObject:(Departure *)value;
- (void)addDepartures:(NSSet *)values;
- (void)removeDepartures:(NSSet *)values;

- (void)addDeparturesDirectStationObject:(Departure *)value;
- (void)removeDeparturesDirectStationObject:(Departure *)value;
- (void)addDeparturesDirectStation:(NSSet *)values;
- (void)removeDeparturesDirectStation:(NSSet *)values;

- (void)insertObject:(SubwayLine *)value inLineAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLineAtIndex:(NSUInteger)idx;
- (void)insertLine:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLineAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLineAtIndex:(NSUInteger)idx withObject:(SubwayLine *)value;
- (void)replaceLineAtIndexes:(NSIndexSet *)indexes withLine:(NSArray *)values;
- (void)addLineObject:(SubwayLine *)value;
- (void)removeLineObject:(SubwayLine *)value;
- (void)addLine:(NSOrderedSet *)values;
- (void)removeLine:(NSOrderedSet *)values;
@end
