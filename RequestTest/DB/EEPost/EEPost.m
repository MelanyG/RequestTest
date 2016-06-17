//
//  EEPostN.m
//  RequestTest
//
//  Created by Melany on 6/16/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEPost.h"

@interface EEPost ()

@property (nonatomic, strong)NSMutableDictionary *backingStore;

@end

@implementation EEPost

@dynamic postID;
@dynamic postTitle;
@dynamic postBody;
//@dynamic user;

-(id)init {
    if((self = [super init])) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    if([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, selector, (IMP)postSetter, "v@:@");
    } else {
        class_addMethod(self, selector, (IMP)postGetter, "@@:");
    }
    return YES;
}

id postGetter(id self, SEL _cmd) {
    EEPost *typedSelf = (EEPost *)self;
    NSMutableDictionary *backingstore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingstore objectForKey:key];
}

void postSetter(id self, SEL _cmd, id value) {
    EEPost *typedefSelf = (EEPost *)self;
    NSMutableDictionary *backingStore = typedefSelf.backingStore;
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    NSString *lowerString = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowerString];
    if(value) {
        [backingStore setObject:value forKey:key];
    } else {
        [backingStore removeObjectForKey:key];
    }
}


@end
