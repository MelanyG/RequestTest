//
//  EEDownloading.h
//  RequestTest
//
//  Created by Melany on 6/13/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import <MagicalRecord/MagicalRecord.h>
#import "AFNetworking.h"
#import "DBManager.h"

@protocol EEDownloadingDelegate <NSObject>

- (void)downloadingDelegateMethod;

@end

@interface EEDownloading : NSObject

@property (nonatomic, weak) id <EEDownloadingDelegate> delegate;

-(void)downloadUserData;
-(void)downloadUserPosts;

@end
