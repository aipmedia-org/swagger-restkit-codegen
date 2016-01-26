//
//  CoreDataManager.h
//  FMCG
//
//  Created by Andrey Toropchin on 26.01.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject
+ (void)setup;
+ (void)save;
+ (NSArray*)getEntitiesWithName:(NSString*)entityName predicate:(NSPredicate*)predicate sortDescriptors:(NSArray*)sortDescriptors;
+ (NSString*)identifierForClass:(Class)cls;
@end
