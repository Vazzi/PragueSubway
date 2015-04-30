//
//  DataService.h
//  PragueSubway
//
//  Created by Jakub Vlasák on 19/04/15.
//  Copyright (c) 2015 Jakub Vlasák. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DataService : NSObject

+ (DataService *)sharedService;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, atomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray *)recordsIn:(NSString *) entityString withPredicate:(NSPredicate *)predicate;
- (id)recordIn:(NSString *) entityString withPredicate:(NSPredicate *)predicate;
- (NSArray *)recordsIn:(NSString *) entityString
             predicate:(NSPredicate *)predicate
                  sort:(NSSortDescriptor *)sortDescriptor;

@end
