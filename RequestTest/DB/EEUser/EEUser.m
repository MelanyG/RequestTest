//
//  EEUserN.m
//  RequestTest
//
//  Created by Melany on 6/16/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEUser.h"


@implementation EEUser

@dynamic latitude;
@dynamic longitude;
@dynamic realName;
@dynamic userId;
@dynamic userName;
@dynamic userCity;
@dynamic companyName;

-(id)init {
    if((self = [super init])) {
        _posts = [NSMutableArray new];
    }
    return self;
}


@end
