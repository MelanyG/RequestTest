//
//  PostsViewControllerTableViewController.h
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EEPostsVC : UITableViewController <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *userName;
@property (assign, nonatomic) NSInteger index;

@end