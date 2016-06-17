//
//  AbstractDynamicClass.h
//  RequestTest
//
//  Created by Melany on 6/17/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AbstractDynamicClass : NSObject

@property (strong, nonatomic) NSMutableDictionary *backingStore;

@end
