//
//  ASCourseViewController.m
//  HW_41-44_CoreData
//
//  Created by MD on 09.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASCourseViewController.h"

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
    //[self deleteAllObjects];
}


-(void) addEntityAction:(id) sender {
    
    NSLog(@"addEntityAction - ASCourse View Controller");
   /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASEditStudentsViewController *vc = (ASEditStudentsViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASEditStudentsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
    */
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Count student %@",[course valueForKeyPath:@"@count.students"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASEditStudentsViewController *vc = (ASEditStudentsViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASEditStudentsViewController"];
    vc.student = student;
    
    [self.navigationController pushViewController:vc animated:YES];
    */
    
    
}


@end
