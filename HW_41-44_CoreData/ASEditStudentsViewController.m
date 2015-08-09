//
//  ASEditStudentsViewController.m
//  HW_41-44_CoreData
//
//  Created by MD on 06.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASEditStudentsViewController.h"

@interface ASEditStudentsViewController ()

@end

@implementation ASEditStudentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(doneButtonAction:)];
    
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    
    if (self.student  != nil) {
        self.firstNameField.text = _student.firstName;
        self.lastNameField.text  = _student.lastName;
        self.emailField.text     = _student.email;
        self.navigationItem.title = @"Edit Student";
    } else {
        self.navigationItem.title = @"Create Student";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[ASDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}


#pragma mark - Action

-(void) doneButtonAction:(id)sender {
    
    
    if (self.student == nil) {
    
        // Сохрание нового студента
        NSEntityDescription* student = [NSEntityDescription insertNewObjectForEntityForName:@"ASStudents"
                                                                     inManagedObjectContext:self.managedObjectContext];
        [student setValue:self.firstNameField.text forKey:@"firstName"];
        [student setValue:self.lastNameField.text  forKey:@"lastName"];
        [student setValue:self.emailField.text     forKey:@"email"];

        
    } else {
        // Редактирование старого студента
        [self.student setValue:self.firstNameField.text  forKey:@"firstName"];
        [self.student setValue:self.lastNameField.text  forKey:@"lastName"];
        [self.student setValue:self.emailField.text      forKey:@"email"];
   
      
    }

    NSError* error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
