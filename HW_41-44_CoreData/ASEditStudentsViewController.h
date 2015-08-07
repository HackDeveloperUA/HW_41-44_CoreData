//
//  ASEditStudentsViewController.h
//  HW_41-44_CoreData
//
//  Created by MD on 06.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ASCoreDataViewController.h"
#import "ASDataManager.h"
#import "ASStudents.h"


@interface ASEditStudentsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) ASStudents* student;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

@end
