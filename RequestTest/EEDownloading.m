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
    [self.operation GET:UserURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.usersDictionary = (NSArray *)responseObject;
        [self parseReceivedData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error %@", [error localizedDescription]);
    }];
}

-(void)downloadusers{
self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    self.activityIndicator.center = [[UIApplication sharedApplication] keyWindow].center;//self.view.center;
    
    self.activityIndicator.color = [UIColor blackColor];
    [self.activityIndicator startAnimating];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.activityIndicator];

    EEUser *user = [EEUser MR_createEntity];
    user.realName = @"Peter Pan";
    user.userName = @"smallPeter";
    user.userId = @(1);
    user.userCity =@"New York";
    user.companyName =@"HP";
    user.latitude = @(40.71f);
    user.longitude = @(74.00f);
    EEUser *user2 = [EEUser MR_createEntity];
    user2.realName = @"John Broke";
    user2.userName = @"johny";
    user2.userId = @(2);
    user2.userCity =@"London";
    user2.companyName =@"Kingspan";
    user2.latitude = @(51.50f);
    user2.longitude = @(0.12f);
    EEUser *user3 = [EEUser MR_createEntity];
    user3.realName = @"Heelen Miles";
    user3.userName = @"slily";
    user3.userId = @(3);
    user3.userCity =@"Sydney";
    user3.companyName =@"Lafarge";
    user3.longitude = @(151.20f);
    user3.latitude = @(-33.86f);
    [DBManager saveContext];
    [self.activityIndicator stopAnimating];
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
    for(int i = 0; i<10; i++) {
        EEUser *user = [EEUser MR_createEntity];
        user.realName = [self.usersDictionary objectAtIndex:i][@"name"];
        user.userName = [[self.usersDictionary objectAtIndex:i]objectForKey:@"username"];
        user.userId = [[self.usersDictionary objectAtIndex:i]objectForKey:@"id"];
        user.userCity =[self.usersDictionary objectAtIndex:i][@"address"][@"city"];
        user.companyName =[[[self.usersDictionary objectAtIndex:i]objectForKey:@"company"] objectForKey:@"name"];
        user.longitude = @([[[[[self.usersDictionary objectAtIndex:i]objectForKey:@"address"] objectForKey:@"geo"]objectForKey:@"lng"]floatValue]);
        user.latitude = @([[[[[self.usersDictionary objectAtIndex:i]objectForKey:@"address"] objectForKey:@"geo"]objectForKey:@"lat"]floatValue]);
    }
    [DBManager saveContext];
    [self.activityIndicator stopAnimating];
}

-(void)parsePosts {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSInteger qty = [self.postsArray count];
        NSInteger userID = 1;
        EEUser *person = [EEUser MR_findFirstByAttribute:@"userId"
                                               withValue:@(userID) inContext:localContext];
        for (int i = 0; i < qty; i++) {
            
            if([[[_postsArray objectAtIndex:i]valueForKey:@"userId"]integerValue] != userID) {
                userID ++;
                person = [EEUser MR_findFirstByAttribute:@"userId"
                                               withValue:@(userID) inContext:localContext];
            }
            EEPost *post = [EEPost MR_createEntityInContext:localContext];
            post.postTitle = [[_postsArray objectAtIndex:i]valueForKey:@"title"];
            post.postBody = [[_postsArray objectAtIndex:i]valueForKey:@"body"];
            post.postID =@([[[_postsArray objectAtIndex:i]valueForKey:@"id"]integerValue]);
            [person addPostsObject:post];
            
        }
        
    } completion:^(BOOL success, NSError *error) {
        if(error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSLog(@"success");
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"record"];
        }
    }];

}



@end
