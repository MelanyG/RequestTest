//
//  PostsViewControllerTableViewController.m
//  RequestTest
//
//  Created by Melany on 6/9/16.
//  Copyright © 2016 Melany. All rights reserved.
//

#import "EEPostsVC.h"
#import "DBManager.h"
#import "EEPostBodyVC.h"
#import "EEPostCell.h"

@interface EEPostsVC () {
    NSString *_title;
    NSString *_body;
    //NSInteger index;
    
}
@property (strong, nonatomic)DBManager *manager;
@end

@implementation EEPostsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.manager = [DBManager sharedManager];
    self.navigationItem.title =_userName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Segues
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showPosts"]) {
//        //        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        //        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        //        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        //        [controller setDetailItem:object];
//        //        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        //        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [[[self.manager.dataBase objectAtIndex:self.index] posts]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    EEPostCell *lCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    if (lCell == nil) {
        lCell = [[EEPostCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
   // EEPost *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:lCell withObject:[[[self.manager.dataBase objectAtIndex:self.index]posts] objectAtIndex:indexPath.row]];
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
    _title = [(EEPostCell *)[tableView cellForRowAtIndexPath:indexPath] title].text;
    _body = [(EEPostCell *)[tableView cellForRowAtIndexPath:indexPath] body].text;

    [self performSegueWithIdentifier:@"body" sender: indexPath];
    
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"body"]) {
        EEPostBodyVC *controller = segue.destinationViewController;
        controller.userName = _userName;
        controller.postTitle = _title;
        controller.postBody = _body;
    }
}

- (void)configureCell:(EEPostCell *)cell withObject:(EEPost *)object {
    cell.title.text = object.postTitle;
    cell.body.text = object.postBody;
}

@end
