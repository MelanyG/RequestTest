//
//  EEPost+CoreDataProperties.h
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EEPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface EEPost (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *postID;
@property (nullable, nonatomic, retain) NSString *postTitle;
@property (nullable, nonatomic, retain) NSString *postBody;
@property (nullable, nonatomic, retain) EEUser *user;

@end

NS_ASSUME_NONNULL_END
