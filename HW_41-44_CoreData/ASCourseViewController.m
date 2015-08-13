//
//  ASCourseViewController.m
//  HW_41-44_CoreData
//
//  Created by MD on 09.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//
#import "ASDetailViewController.h"
#import "ASCourseViewController.h"
#import "ASCourse.h"

@interface ASCourseViewController ()

@end

@implementation ASCourseViewController
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ASCourse";
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) deleteEntityAction:(id) sender {
    
    NSLog(@"deleteEntityAction - ASCourse View Controller");
    [[ASDataManager sharedManager] deleteAllObjects:@"ASCourse"];
}


-(void) addEntityAction:(id) sender {
    

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASDetailViewController *detailVC = (ASDetailViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    
    
    detailVC.className    =  [ASCourse class];
    detailVC.objectEntity =  nil;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}



- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ASCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    

    
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ASCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",course.name,course.subject];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Count student %@",[course valueForKeyPath:@"students.@count"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    
    ASCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASDetailViewController *detailVC = (ASDetailViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ASCourse" inManagedObjectContext:[[ASDataManager sharedManager] managedObjectContext]];

    detailVC.className    =  [ASCourse class];
    detailVC.objectEntity = course;
    detailVC.course       = course;
    detailVC.navigationItem.title = @"Edit Course";

    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
