//
//  EEDownloading.m
//  RequestTest
//
//  Created by Melany on 6/13/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEDownloading.h"

static NSString * const UserURLString = @"http://jsonplaceholder.typicode.com/users";
static NSString * const UserPostsString = @"http://jsonplaceholder.typicode.com/posts";

@interface EEDownloading ()

@property (strong, nonatomic)NSArray *usersDictionary;
@property (strong, nonatomic)NSArray *postsArray;
@property (strong, nonatomic) AFHTTPSessionManager *operation;
@property (strong, nonatomic)UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic)DBManager *manager;

@end

@implementation EEDownloading

#pragma mark - AFNetworking

-(void)downloadUserData {
    
    self.activityIndicator = [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.activityIndicator.center = [[UIApplication sharedApplication] keyWindow].center;//self.view.center;
    
    self.activityIndicator.color = [UIColor blackColor];
    [self.activityIndicator startAnimating];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.activityIndicator];
    
    
    NSURL *url = [NSURL URLWithString:UserURLString];
    self.operation = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    // self.operation.su
    [self.operation GET:UserURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.usersDictionary = (NSArray *)responseObject;
        [self parseReceivedData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error %@", [error localizedDescription]);
    }];
}



-(void)downloadUserPosts {
    NSURL *url = [NSURL URLWithString:UserPostsString];
    self.operation = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    [self.operation GET:UserPostsString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.postsArray = (NSArray *)responseObject;
        [self parsePosts];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error %@", [error localizedDescription]);
        
    }];
    
}

-(void)parseReceivedData {
    self.manager = [DBManager sharedManager];
    NSInteger qty = [self.usersDictionary count];
    for(int i = 0; i<qty; i++) {
        EEUser *user = [EEUser new];
        user.realName = [self.usersDictionary objectAtIndex:i][@"name"];
        user.userName = [[self.usersDictionary objectAtIndex:i]objectForKey:@"username"];
        user.userId = [[self.usersDictionary objectAtIndex:i]objectForKey:@"id"];
        user.userCity =[self.usersDictionary objectAtIndex:i][@"address"][@"city"];
        user.companyName =[[[self.usersDictionary objectAtIndex:i]objectForKey:@"company"] objectForKey:@"name"];
        user.longitude = @([[[[[self.usersDictionary objectAtIndex:i]objectForKey:@"address"] objectForKey:@"geo"]objectForKey:@"lng"]floatValue]);
        user.latitude = @([[[[[self.usersDictionary objectAtIndex:i]objectForKey:@"address"] objectForKey:@"geo"]objectForKey:@"lat"]floatValue]);
        [self.manager.dataBase addObject:user];
    }
    //[DBManager saveContext];
    if(_delegate && [_delegate respondsToSelector:@selector(downloadingDelegateMethod)]) {
        [_delegate downloadingDelegateMethod];
    }
    
    [self.activityIndicator stopAnimating];
    [self downloadUserPosts];
}

-(void)parsePosts {
    // [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
    self.manager = [DBManager sharedManager];
    
    NSInteger qty = [self.postsArray count];
    NSInteger usersIndex = 0;
    NSInteger userID = 1;
    //      EEUser *person = [EEUser MR_findFirstByAttribute:@"userId"
    //                                              withValue:@(userID) inContext:localContext];
    for (int i = 0; i < qty; i++) {
        
        if([[[_postsArray objectAtIndex:i]valueForKey:@"userId"]integerValue] != userID) {
            if(usersIndex < 10) {
                userID ++;
                usersIndex ++;
            }
        }
        
        // person = [EEUser MR_findFirstByAttribute:@"userId"
        //                                withValue:@(userID) inContext:localContext];
        
        EEPost *post = [EEPost new];
        post.postTitle = [[_postsArray objectAtIndex:i]valueForKey:@"title"];
        post.postBody = [[_postsArray objectAtIndex:i]valueForKey:@"body"];
        post.postID =@([[[_postsArray objectAtIndex:i]valueForKey:@"id"]integerValue]);
        //post.user = person;
        [[[self.manager.dataBase objectAtIndex:usersIndex]posts] addObject:post];
        
    }
    
    
}



@end
