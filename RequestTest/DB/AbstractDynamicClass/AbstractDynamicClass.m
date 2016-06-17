//
//  AbstractDynamicClass.m
//  RequestTest
//
//  Created by Melany on 6/17/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "AbstractDynamicClass.h"

@implementation AbstractDynamicClass

-(id)init {
    if((self = [super init])) {
        _backingStore = [NSMutableDictionary new];
        //_posts = [NSMutableArray new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    if([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, selector, (IMP)postNSetter, "v@:@");
    } else {
        class_addMethod(self, selector, (IMP)postNGetter, "@@:");
    }
    return YES;
}

id postNGetter(id self, SEL _cmd) {
    AbstractDynamicClass *typedSelf = (AbstractDynamicClass *)self;
    NSMutableDictionary *backingstore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingstore objectForKey:key];
}

void postNSetter(id self, SEL _cmd, id value) {
    AbstractDynamicClass *typedefSelf = (AbstractDynamicClass *)self;
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
