//
//  EEDownloading.h
//  RequestTest
//
//  Created by Melany on 6/13/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "AFNetworking.h"
#import "DBManager.h"

@interface EEDownloading : NSObject

-(void)downloadUserData;
-(void)downloadUserPosts;
-(void)downloadusers;

@end
