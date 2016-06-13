//
//  EEUser+CoreDataProperties.h
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EEUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface EEUser (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *realName;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *userCity;
@property (nullable, nonatomic, retain) NSSet<EEPost *> *posts;

@end

@interface EEUser (CoreDataGeneratedAccessors)

- (void)addPostsObject:(EEPost *)value;
- (void)removePostsObject:(EEPost *)value;
- (void)addPosts:(NSSet<EEPost *> *)values;
- (void)removePosts:(NSSet<EEPost *> *)values;

@end

NS_ASSUME_NONNULL_END
