//
//  DBManager.h
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import <MagicalRecord/MagicalRecord.h>
#import "EEUser.h"
#import "EEPost.h"

@interface DBManager : NSObject

@property (strong, nonatomic)NSMutableArray *dataBase;

+ (id)sharedManager;

@end
