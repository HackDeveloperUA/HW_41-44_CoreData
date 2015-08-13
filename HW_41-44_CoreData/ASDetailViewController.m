//
//  ASDetailViewController.m
//  HW_41-44_CoreData
//
//  Created by MD on 10.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//
#import "UIView+SuperTableViewCell.h"
#import "ASDetailViewController.h"
#import "ASDetailTableViewCell.h"

#import "ASCourse.h"
#import "ASStudents.h"
#import "ASTeacher.h"


@interface ASDetailViewController ()

@end


@implementation ASDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"Class Name = %@",self.className);
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneButtonAction:)];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                target:self
                                                                                action:@selector(refreshButtonAction:)];

    self.students = [self studentsRequest];
    self.teachers = [self teachersRequest];
    self.courses  = [self coursesRequest];

    NSLog(@"[self.courses count] = %d",[self.courses count]);
    NSLog(@"[self.teachers count] = %d",[self.teachers count]);
    NSLog(@"[self.students count] = %d",[self.students count]);

    self.navigationItem.rightBarButtonItems = @[refreshButton,doneButton];

    
    if (!self.objectEntity) {
        
        if ([self.className isSubclassOfClass:[ASCourse class]]) {

            self.course = [NSEntityDescription insertNewObjectForEntityForName:@"ASCourse"  inManagedObjectContext:
                          [[ASDataManager sharedManager] managedObjectContext]];
            self.navigationItem.title = @"Create Course";

        }
        
        if ([self.className isSubclassOfClass:[ASTeacher class]]) {
           
            self.teacher = [NSEntityDescription insertNewObjectForEntityForName:@"ASTeacher"  inManagedObjectContext:
                           [[ASDataManager sharedManager] managedObjectContext]];
            self.navigationItem.title = @"Create Teacher";

            
        }
        
        if ([self.className isSubclassOfClass:[ASStudents class]]) {
            
            self.student = [NSEntityDescription insertNewObjectForEntityForName:@"ASStudents"  inManagedObjectContext:
                            [[ASDataManager sharedManager] managedObjectContext]];
            self.navigationItem.title = @"Create Student";

        }
       
        self.isEdit = NO;
        
    } else {
        self.isEdit = YES;
    }
    
    self.isSave = NO;
    
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChageNotification:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    

}

-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action


-(void)viewWillDisappear:(BOOL)animated {
    
    if (self.isSave == NO && self.isEdit == NO) {
       
        if ([self.className isSubclassOfClass:[ASCourse class]]) {
           [[[ASDataManager sharedManager] managedObjectContext] deleteObject:self.course];
        }
        
        
        if ([self.className isSubclassOfClass:[ASTeacher class]]) {
             [[[ASDataManager sharedManager] managedObjectContext] deleteObject:self.teacher];
        }
        
        
        if ([self.className isSubclassOfClass:[ASStudents class]]) {
           [[[ASDataManager sharedManager] managedObjectContext] deleteObject:self.student];
        }
        
       [[[ASDataManager sharedManager] managedObjectContext] save:nil];
    }

}

-(void) refreshButtonAction:(id)sender {

    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    indicatorView.center = self.view.center;
    self.indicator       = indicatorView;
    [self.view addSubview:self.indicator ];

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    
    if ([self.className isSubclassOfClass:[ASCourse class]])
    {   [indexSet addIndex:1];  [indexSet addIndex:2]; }
    

    if ([self.className isSubclassOfClass:[ASTeacher class]])
      { [indexSet addIndex:1];}
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.indicator startAnimating];
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
            self.students = [self studentsRequest];
            self.teachers = [self teachersRequest];
            self.courses  = [self coursesRequest];
            
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            [self.indicator stopAnimating];
            
        });
    });
}


-(void) doneButtonAction:(id)sender {
    
    self.isSave = YES;
    NSLog(@"doneButtonAction");

    
    NSError* error = nil;
    
    if (![[[ASDataManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TextFieldDelegate


-(void)textFieldDidChageNotification:(NSNotification*) notification {
    UITextField* textField = notification.object;
    [self textFieldShouldEndEditing:textField];
}



-(void)textFieldShouldEndEditing:(UITextField *)textField {
    
    ASDetailTableViewCell* cell = (ASDetailTableViewCell*)[textField superTableViewCell];
    
    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        
        if ([cell.label.text isEqualToString:@"Name Course"])
        {   [self.course setName:textField.text];}
    
        if ([cell.label.text isEqualToString:@"Subject"])
        {   [self.course setSubject:textField.text]; }
        
        if ([cell.label.text isEqualToString:@"Branch"])
        {   [self.course setBranch:textField.text]; }
    }
    
    
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {
        
        if ([cell.label.text isEqualToString:@"First Name"])
        { [self.teacher setFirstName:textField.text]; }
        
        if ([cell.label.text isEqualToString:@"Last Name"])
        {  [self.teacher setLastName:textField.text]; }
        
     }
    
    
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
        
        if ([cell.label.text isEqualToString:@"First Name"])
        {  [self.student setFirstName:textField.text]; }
        
        if ([cell.label.text isEqualToString:@"Last Name"])
        {  [self.student setLastName:textField.text]; }
        
        
        if ([cell.label.text isEqualToString:@"Email"])
        { [self.student setEmail:textField.text];  }
    }

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


        if ([self.className isSubclassOfClass:[ASCourse class]]) {
            
            switch (indexPath.section) {
                case 1:  return 35; break;
                case 2:  return 35; break;
               default: return 55;  break;

            }
        }

        if ([self.className isSubclassOfClass:[ASTeacher class]]) {

            switch (indexPath.section) {
                case 2:  return 35; break;
                default: return 55;  break;
            }
        }

    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
        
        return 55;
    }

  return 1;

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        return 3;
    }
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {
        return 2;
    }
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
       //return 2;
        return 3;
    }
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        
        //ASCourse* course = (ASCourse*)self.objectEntity;

        switch (section) {
            case 0:  return 3;  break;
            case 1:  return [self.teachers count]; break;
            case 2:  return [self.students count]; break;
            //default: return 1;  break;
        }
    }
    
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {
      
    // ASTeacher* teacher = (ASTeacher*)self.objectEntity;
   
        switch (section) {
            case 0:  return 2;  break;
            case 1:  return [self.courses count];   break;
           // default: return 1;  break;
        }
    }
    
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
      
        switch (section) {
              case 0:  return 2;  break;
              case 1:  return 1;  break;
              case 2:  return [self.courses count]; break;
                //default: return 1;  break;
            }
      }
 
    return 1;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        switch (section) {
            case 0: return @"General";  break;
            case 1: return @"Teacher";  break;
            case 2: return @"Students"; break;
            //default:break;
        }
    }
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {
        switch (section) {
            case 0: return @"General";         break;
            case 1: return @"Teacher Courses"; break;
            //default:break;
        }
    }
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
        switch (section) {
            case 0: return @"Initials";  break;
            case 1: return @"Other";     break;
            case 2: return @"Courses";   break;

            //default:break;
        }
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        
        
                static NSString* identifier = @"detailCell";
                
                if (indexPath.section == 0) {
                
                    ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
                    if (cell == nil)
                    { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]; }
                
                    switch (indexPath.row) {
                            
                        case 0:  cell.label.text = @"Name Course"; cell.textField.text = self.course.name;    break;
                        case 1:  cell.label.text = @"Subject";     cell.textField.text = self.course.subject; break;
                        case 2:  cell.label.text = @"Branch";      cell.textField.text = self.course.branch;  break;

                        default: NSLog(@"Не нашел cell");  break;
                    }
                 return cell;
              }
        
        
        
                  if (indexPath.section == 1) {

                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"teacherCell"];
                    if (cell == nil)
                    { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"teacherCell"]; }
                     
                      NSString* fullName = [NSString stringWithFormat:@"%@ %@",[[self.teachers objectAtIndex:indexPath.row] firstName],
                                                                                [[self.teachers objectAtIndex:indexPath.row] lastName]];
                     
                      NSLog(@"indexPath.section = %d  indexPath.row = %d",indexPath.section,indexPath.row);
                      cell.textLabel.text = fullName;

                         if ([self.course.teachers containsObject:[self.teachers objectAtIndex:indexPath.row]]){
                                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                             } else {
                                cell.accessoryType = UITableViewCellAccessoryNone;
                             }
                 
                      return cell;
                    }
        
        
                   if (indexPath.section == 2) {
            
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell"];
                    if (cell == nil)
                    { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"studentCell"]; }

                       NSString* fullName = [NSString stringWithFormat:@"%@ %@",[[self.students objectAtIndex:indexPath.row] firstName],
                                                                                 [[self.students objectAtIndex:indexPath.row] lastName]];
                       
                       cell.textLabel.text = fullName;
                       
                       
                       if ([self.course.students containsObject:[self.students objectAtIndex:indexPath.row]]){
                           cell.accessoryType = UITableViewCellAccessoryCheckmark;
                       } else {
                           cell.accessoryType = UITableViewCellAccessoryNone;
                       }
                       
                    return cell;
                    }
      }
    
    
    
    /////////
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {

        static NSString* identifier = @"detailCell";
        
        //ASTeacher* teacher = (ASTeacher*)self.objectEntity;
        
        ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
       
        if (cell == nil)
        { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]; }
        
        if (indexPath.section == 0) {
            
            switch (indexPath.row) {
                    
                case 0:  cell.label.text = @"First Name";  cell.textField.text = self.teacher.firstName; break;
                case 1:  cell.label.text = @"Last Name";   cell.textField.text = self.teacher.lastName; break;

                default: NSLog(@"Не нашел cell");  break;
            }
        } else {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"courseCell"];
            }

            NSLog(@"indexPath.section = %d  indexPath.row = %d",indexPath.section,indexPath.row);

            cell.textLabel.text = [[self.courses objectAtIndex:indexPath.row] name];
            
            if ([self.teacher.courses containsObject:[self.courses objectAtIndex:indexPath.row]]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
        }
        return cell;
    }
    
    
    /////////////
    
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
    
        static NSString* identifier = @"detailCell";
        


        if (indexPath.section == 0) {

            ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]; }
            
            
            switch (indexPath.row) {
                    
                case 0:  cell.label.text = @"First Name"; cell.textField.text = self.student.firstName; break;
                case 1:  cell.label.text = @"Last Name";  cell.textField.text = self.student.lastName;  break;
                    
                default: NSLog(@"Не нашел cell");  break;
            }
            return cell;
        }
    
    
        if (indexPath.section == 1) {
            
            ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]; }
            
            
            cell.label.text = @"Email"; cell.textField.text = self.student.email;
            return  cell;
         }
        
        if (indexPath.section == 2) {

            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"studentCell"];
            }
            
            
            cell.textLabel.text = [[self.courses objectAtIndex:indexPath.row] name];
            
            if ([self.student.courses containsObject:[self.courses objectAtIndex:indexPath.row]]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
          
          }
    }
    
    
    return nil;
}



#pragma mark - Requests

-(NSArray*)studentsRequest {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"ASStudents"
                                                   inManagedObjectContext:[[ASDataManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    return [[[ASDataManager sharedManager] managedObjectContext]
            executeFetchRequest:request
            error:nil];
}

-(NSArray*)teachersRequest {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"ASTeacher" inManagedObjectContext:[[ASDataManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    return [[[ASDataManager sharedManager] managedObjectContext]
            executeFetchRequest:request
            error:nil];
}

-(NSArray*)coursesRequest {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"ASCourse"
                                                   inManagedObjectContext:[[ASDataManager sharedManager] managedObjectContext]];
    
    [request setEntity:description];
    
    NSSortDescriptor* nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[nameDescriptor]];
    
    return [[[ASDataManager sharedManager] managedObjectContext]
            executeFetchRequest:request
            error:nil];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL isAdded = YES;
    
    if (indexPath.section != 0) {
        
        if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone) {
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
            isAdded = NO;
        }
        
        if ([self.className isSubclassOfClass:[ASCourse class]]) {

            if (indexPath.section == 1 && isAdded) {
                [self.course addTeachersObject:[self.teachers objectAtIndex:indexPath.row]];
            }
            
            if (indexPath.section == 1 && !isAdded) {
                [self.course removeTeachersObject:[self.teachers objectAtIndex:indexPath.row]];
            }
            
            if (indexPath.section == 2 && isAdded) {
                [self.course addStudentsObject:[self.students objectAtIndex:indexPath.row]];
            }
            
            if (indexPath.section == 2 && !isAdded) {
                [self.course removeStudentsObject:[self.students objectAtIndex:indexPath.row]];
            }
            
        }
        
        
        
        if ([self.className isSubclassOfClass:[ASTeacher class]]) {

            if (indexPath.section == 1 && isAdded) {
                [self.teacher addCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            }
            
            if (indexPath.section == 1 && !isAdded) {
                [self.teacher removeCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            }
         }
        
        
        
        if ([self.className isSubclassOfClass:[ASStudents class]]) {

            if (isAdded) {
                [self.student addCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            } else {
                [self.student removeCoursesObject:[self.courses objectAtIndex:indexPath.row]];
            }   
        }
        
    }
    
    [[ASDataManager sharedManager] saveContext];
 
    
}

@end
