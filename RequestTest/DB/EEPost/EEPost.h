//
//  EEPostN.h
//  RequestTest
//
//  Created by Melany on 6/16/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class EEUser;

@interface EEPost : NSObject

@property (nullable, nonatomic, retain) NSNumber *postID;
@property (nullable, nonatomic, retain) NSString *postTitle;
@property (nullable, nonatomic, retain) NSString *postBody;
//@property (nullable, nonatomic, retain) EEUser *user;


//+ (BOOL)resolveInstanceMethod:(SEL)selector;








@end
