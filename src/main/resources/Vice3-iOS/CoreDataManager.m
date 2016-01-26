//
//  CoreDataManager.m
//  FMCG
//
//  Created by Andrey Toropchin on 26.01.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

#import "CoreDataManager.h"
#ifdef ENABLE_CUSTOMIZATION
#import "CoreDataCustomization.h"
#endif
#import <CoreData.h>
#import "BaseApi.h"
#import <objc/message.h>

@implementation CoreDataManager

+ (void)setup
{
    if ([RKManagedObjectStore defaultStore] != nil)
        return;

    // Configure RestKit's Core Data stack
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    [BaseApi objectManager].managedObjectStore = managedObjectStore;

    // Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];

    // Persistent Store
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"db.sqlite"];

    // Create the persistent store
    NSError *error = nil;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                                     fromSeedDatabaseAtPath:nil
                                                                          withConfiguration:nil
                                                                                    options:nil
                                                                                      error:&error];
    if (error != nil)
    {
        if (error.code == 134130)
        {
            NSLog(@"Failed to add persistent store at path %@. Probably the underlying model changed. Removing the store and creating a new one.", storePath);

            NSError *error = nil;
            if ([[NSFileManager defaultManager] removeItemAtPath:storePath
                                                           error:&error])
            {
                // ok, try again
                error = nil;
                persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                              fromSeedDatabaseAtPath:nil
                                                                   withConfiguration:nil
                                                                             options:nil
                                                                               error:&error];
            }
            else
            {
                NSLog(@"Error deleting the persistent store at path %@", storePath);
            }
        }
    }
    NSAssert(persistentStore, @"Failed to add persistent store: %@", error);

    [managedObjectStore createManagedObjectContexts];

    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];

    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
}

+ (void)save
{
    if ([[[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext] hasChanges])
    {
        NSError *error;
        BOOL __unused success = [[[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext] saveToPersistentStore:&error];
        NSLog(@"Saved context with %@", success ? @"success." : error);
    }
}

+ (NSArray*)getEntitiesWithName:(NSString*)entityName predicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors
{
    NSManagedObjectContext *context = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.predicate = predicate;

    if (sortDescriptors)
        fetchRequest.sortDescriptors = sortDescriptors;

    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    if (error)
        NSLog(@"Error fetching entities %@: %@", entityName, error);

    return fetchedObjects;
}

+ (NSString*)identifierForClass:(Class)cls
{
    if (class_getProperty(cls, "uid"))
        return @"uid";
    else
#ifdef ENABLE_CUSTOMIZATION
        return [CoreDataCustomization identifierForClass:cls];
#else
        return nil;
#endif
}

@end
