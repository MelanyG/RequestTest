//
//  DBManager.m
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

#pragma mark - Core Data methods

+ (id)sharedManager {
    static DBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DBManager new];
        instance.dataBase = [NSMutableArray array];
        //[MagicalRecord setupCoreDataStackWithStoreNamed:@"EEForm"];
    });
    return instance;
}
//+ (void)saveContext {
//    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_defaultContext];
//    [managedObjectContext MR_saveToPersistentStoreAndWait];
//}

@end
