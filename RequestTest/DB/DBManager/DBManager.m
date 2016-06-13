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

+ (void)saveContext {
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    [managedObjectContext MR_saveToPersistentStoreAndWait];
}

@end
