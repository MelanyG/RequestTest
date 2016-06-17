//
//  EEUserN.h
//  RequestTest
//
//  Created by Melany on 6/16/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class EEPost;

@interface EEUser : NSObject

@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *realName;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *userCity;
@property (nullable, strong, nonatomic) NSMutableArray *posts;
@end
