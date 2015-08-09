//
//  ASStudentsViewController.m
//  HW_41-44_CoreData
//
//  Created by MD on 07.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASStudentsViewController.h"
#import "ASEditStudentsViewController.h"

#import "ASStudents.h"

@interface ASStudentsViewController ()

@end

@implementation ASStudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                target:self
                                                                                action:@selector(deleteButtonAction:)];
    
    
    NSMutableArray* tmpRigthButton = @[self.navigationItem.rightBarButtonItem,deleteButton];
   // NSMutableArray* tmpRigthButton = @[deleteButton];

    self.navigationItem.rightBarButtonItems = tmpRigthButton;
    
    [self printAllObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - actions

-(void) deleteButtonAction:(id) sender {

    [self deleteAllObjects];
}


-(void) deleteAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self.managedObjectContext save:nil];
}



- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ASObject"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printArray:(NSArray*) array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[ASStudents class]]) {
            
            ASStudents* student = (ASStudents*) object;
            NSLog(@"First Name : %@ | Last Name : %@ | Email : %@",
                  student.firstName,student.lastName,student.email);
        }
    }
    
    NSLog(@"COUNT = %d", [array count]);
}

- (void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    [self printArray:allObjects];
}



- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ASStudents"
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
    
    ASStudents *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",student.firstName,student.lastName];
    cell.detailTextLabel.text = student.email;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ASStudents *student = [self.fetchedResultsController objectAtIndexPath:indexPath];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    ASEditStudentsViewController *vc = (ASEditStudentsViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASEditStudentsViewController"];
    vc.student = student;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (IBAction)addStudentAction:(id)sender {
  
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASEditStudentsViewController *vc = (ASEditStudentsViewController *)[storyboard  instantiateViewControllerWithIdentifier:@"ASEditStudentsViewController"];
    
    //ASDoctor* obj = [self.arrayDoctors objectAtIndex:indexPath.row];
    //vc2.obj             = obj;
    
    [self.navigationController pushViewController:vc animated:YES];

}
@end
