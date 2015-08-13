//
//  ASTeacherViewController.m
//  HW_41-44_CoreData
//
//  Created by MD on 09.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASTeacherViewController.h"
#import "ASDetailViewController.h"
#import "ASTeacher.h"

@interface ASTeacherViewController ()

@end

@implementation ASTeacherViewController
@synthesize fetchedResultsController = _fetchedResultsController;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ASTeacher";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) deleteEntityAction:(id) sender {
    
    NSLog(@"deleteEntityAction - ASTeacher View Controller");
    [[ASDataManager sharedManager] deleteAllObjects:@"ASTeacher"];
}


-(void) addEntityAction:(id) sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASDetailViewController *detailVC = (ASDetailViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    
    
    detailVC.className    =  [ASTeacher class];
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
    [NSEntityDescription entityForName:@"ASTeacher"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* firstNameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    NSSortDescriptor* lastNameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    
    [fetchRequest setSortDescriptors:@[firstNameDescription,lastNameDescription]];
    
    
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
    
    ASTeacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",teacher.firstName, teacher.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Count courses %@",[teacher valueForKeyPath:@"courses.@count"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

    ASTeacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASDetailViewController *detailVC = (ASDetailViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    
    detailVC.className    =  [ASTeacher class];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ASTeacher" inManagedObjectContext:[[ASDataManager sharedManager] managedObjectContext]];
    
    detailVC.objectEntity = teacher;
    detailVC.teacher      = teacher;
    detailVC.navigationItem.title = @"Edit Teacher";

    
    NSLog (@"student %@",teacher);
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end
