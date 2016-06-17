//
//  MasterViewController.m
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEUsersVC.h"
#import "DBManager.h"
#import "EEPostsVC.h"
#import "EEDownloading.h"
#import "EELocationVC.h"

@interface EEUsersVC ()<UITableViewDelegate, UITableViewDataSource, EEDownloadingDelegate>

@property (strong, nonatomic)NSString *selectedUserName;
@property (strong, nonatomic)NSNumber *lon;
@property (strong, nonatomic)NSNumber *lat;
@property (strong, nonatomic)NSString *city;
@property (strong, nonatomic)DBManager *manager;

@end

@implementation EEUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
 //   if(![[NSUserDefaults standardUserDefaults] boolForKey:@"record"]) {
    // dispatch_async(dispatch_get_main_queue(), ^{
        EEDownloading *lDownloader = [EEDownloading new];
    lDownloader.delegate = self;
        [lDownloader downloadUserData];
        //[lDownloader downloadUserPosts];
  //         });
        self.manager = [DBManager sharedManager];
    self.tableView.delegate=nil;
    self.tableView.dataSource=nil;
        //        [lDownloader downloadusers];
 //   }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"USERS";
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPosts"]) {
        EEPostsVC *controller = segue.destinationViewController;
        controller.userName = _selectedUserName;
    } else if ([[segue identifier] isEqualToString:@"map"]) {
        EELocationVC *controller = segue.destinationViewController;
        controller.longit = self.lon;
        controller.latitud = self.lat;
        controller.city = self.city;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   //id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [self.manager.dataBase count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    // EEUserCell *lCell = [[EEUserCell alloc] init];
    
    EEUserCell *lCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // [tableView registerClass:[EEUserCell class] forCellReuseIdentifier:@"cell"];
    if (!lCell)
    {
        lCell = [[EEUserCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:CellIdentifier];
    }
    
    //EEUser *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:lCell withObject:[self.manager.dataBase objectAtIndex:indexPath.row] withIndexPath:indexPath];
    lCell.delegate = self;
    [lCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return lCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedUserName = [(EEUserCell *)[tableView cellForRowAtIndexPath:indexPath] userName].text;

    [self performSegueWithIdentifier:@"showPosts" sender: indexPath];
    
    
}

- (void)configureCell:(EEUserCell *)cell withObject:(EEUser *)object withIndexPath:(NSIndexPath *)index{
    cell.userName.text = object.realName;
    cell.userCompany.text = object.companyName;
    cell.userCity.text = object.userCity;
    cell.index = index;
    
}

#pragma mark - delegate methods

- (void) cellDelegateMethod:(NSIndexPath *)index {
    self.lon = [[self.manager.dataBase objectAtIndex:index.row]longitude];
    self.lat = [[self.manager.dataBase objectAtIndex:index.row]latitude];
    self.city = (NSString *)[[self.manager.dataBase objectAtIndex:index.row]userCity];
    [self performSegueWithIdentifier:@"map" sender: index];
}


- (void)downloadingDelegateMethod {
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
    [self.tableView reloadData];
}


@end
