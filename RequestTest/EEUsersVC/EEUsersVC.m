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

@interface EEUsersVC ()

@property (strong, nonatomic)NSString *selectedUserName;
@property (strong, nonatomic)NSNumber *lon;
@property (strong, nonatomic)NSNumber *lat;
@property (strong, nonatomic)NSString *city;

@end

@implementation EEUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"record"]) {
        EEDownloading *lDownloader = [EEDownloading new];
        [lDownloader downloadUserData];
        [lDownloader downloadUserPosts];
        //        [lDownloader downloadusers];
    }
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
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
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
    
    EEUser *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:lCell withObject:object withIndexPath:indexPath];
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

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [EEUser MR_fetchAllGroupedBy:nil withPredicate:nil sortedBy:@"userId" ascending:YES];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject withIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - delegate methods

- (void) cellDelegateMethod:(NSIndexPath *)index {
    EEUser *user = [[self fetchedResultsController] objectAtIndexPath:index];
    self.lon = user.latitude;
    self.lat = user.longitude;
    self.city = user.userCity;
                              
    [self performSegueWithIdentifier:@"map" sender: index];
}



@end
