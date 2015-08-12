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
    
    
    //self.navigationItem.title = (NSString*)self.className;
    self.navigationItem.rightBarButtonItem = doneButton;
    /*
    if (!self.objectEntity) {
        
        if ([self.className isSubclassOfClass:[ASCourse class]]) {
            
            ASCourse* course = [NSEntityDescription insertNewObjectForEntityForName:@"ASCourse" inManagedObjectContext:
                                [[ASDataManager sharedManager] managedObjectContext]];
            self.objectEntity = course;
            
        }
        
        if ([self.className isSubclassOfClass:[ASTeacher class]]) {
            
            ASTeacher* teacher = [NSEntityDescription insertNewObjectForEntityForName:@"ASTeacher"  inManagedObjectContext:
                                  [[ASDataManager sharedManager] managedObjectContext]];
            
            self.objectEntity = teacher;
            
        }
        
        if ([self.className isSubclassOfClass:[ASStudents class]]) {
            
            ASStudents* student = [NSEntityDescription insertNewObjectForEntityForName:@"ASStudents" inManagedObjectContext:
                                   [[ASDataManager sharedManager] managedObjectContext]];
            self.objectEntity = student;
        }
    }*/
    
    /*
    if (!self.objectEntity) {
        
        if ([self.className isSubclassOfClass:[ASCourse class]]) {
            
            ASCourse* course = [NSEntityDescription entityForName:@"ASCourse" inManagedObjectContext:[[ASDataManager sharedManager] managedObjectContext]];
            self.objectEntity = course;
            
        }
        
        if ([self.className isSubclassOfClass:[ASTeacher class]]) {
            
            ASTeacher* teacher = [NSEntityDescription insertNewObjectForEntityForName:@"ASTeacher"  inManagedObjectContext:
                                  [[ASDataManager sharedManager] managedObjectContext]];
            
            self.objectEntity = teacher;
            
        }
        
        if ([self.className isSubclassOfClass:[ASStudents class]]) {
            
            ASStudents* student = [NSEntityDescription insertNewObjectForEntityForName:@"ASStudents" inManagedObjectContext:
                                   [[ASDataManager sharedManager] managedObjectContext]];
            self.objectEntity = student;
        }
    }*/
    
    
    
    if (!self.objectEntity) {
        
        if ([self.className isSubclassOfClass:[ASCourse class]]) {

            self.course = [NSEntityDescription insertNewObjectForEntityForName:@"ASCourse"  inManagedObjectContext:
                          [[ASDataManager sharedManager] managedObjectContext]];
        }
        
        if ([self.className isSubclassOfClass:[ASTeacher class]]) {
           
            self.teacher = [NSEntityDescription insertNewObjectForEntityForName:@"ASTeacher"  inManagedObjectContext:
                           [[ASDataManager sharedManager] managedObjectContext]];
            
        }
        
        if ([self.className isSubclassOfClass:[ASStudents class]]) {
            
            self.student = [NSEntityDescription insertNewObjectForEntityForName:@"ASStudents"  inManagedObjectContext:
                            [[ASDataManager sharedManager] managedObjectContext]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

/*
-(void)viewWillDisappear:(BOOL)animated {
    if (!self.isAddedSuccessfully && self.allowInteraction) {
        [[[DataManager sharedManager] managedObjectContext] deleteObject:self.object];
        [[[DataManager sharedManager] managedObjectContext] save:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
    self.object = nil;
    self.className = nil;
}*/


-(void) doneButtonAction:(id)sender {
    
   // ASStudents* student = (ASStudents*)self.objectEntity;
   // [[[ASDataManager sharedManager] managedObjectContext] deleteObject:student];
    
    NSError* error = nil;
    if (![[[ASDataManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TextFieldDelegate



-(void)textFieldDidEndEditing:(UITextField *)textField {
    //self.tableView.scrollEnabled = YES;
    
    ASDetailTableViewCell* cell = (ASDetailTableViewCell*)[textField superTableViewCell];
    
    
    if ([self.objectEntity isKindOfClass:[ASCourse class]]) {
        
        if ([cell.label.text isEqualToString:@"Name Course"])
        { [(ASCourse*)self.objectEntity setName:textField.text];}
    
        if ([cell.label.text isEqualToString:@"Subject"])
        { [(ASCourse*)self.objectEntity setSubject:textField.text]; }
        
        if ([cell.label.text isEqualToString:@"Branch"])
        { [(ASCourse*)self.objectEntity setBranch:textField.text]; }
    }
    
    
    
    
    if ([self.objectEntity isKindOfClass:[ASTeacher class]]) {
        
        if ([cell.label.text isEqualToString:@"First Name"]) {
            [(ASTeacher*)self.objectEntity setFirstName:textField.text];
        }
        
        if ([cell.label.text isEqualToString:@"Last Name"]) {
            [(ASTeacher*)self.objectEntity setLastName:textField.text];
        }
     }
    
    
    
    if ([self.objectEntity isKindOfClass:[ASStudents class]]) {
        
        if ([cell.label.text isEqualToString:@"First Name"]) {
            [(ASStudents*)self.objectEntity setFirstName:textField.text];
        }
        
        if ([cell.label.text isEqualToString:@"Last Name"]) {
            [(ASStudents*)self.objectEntity setLastName:textField.text];
        }
        
        if ([cell.label.text isEqualToString:@"Email"]) {
            [(ASStudents*)self.objectEntity setEmail:textField.text];
        }
    }

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        return 3;
    }
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {
        return 2;
    }
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
        return 2;
    }
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        
        ASCourse* course = (ASCourse*)self.objectEntity;

        switch (section) {
            case 0:  return 3;  break;
            case 1:  [course valueForKeyPath:@"teachers.@count"]; break;
            case 2:  [course valueForKeyPath:@"students.@count"]; break;
            default: return 1;  break;
        }
    }
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {
      
     ASTeacher* teacher = (ASTeacher*)self.objectEntity;
   
        switch (section) {
            case 0:  return 2;  break;
            case 1:  [teacher valueForKeyPath:@"courses.@count"];  break;
           // default: return 1;  break;
        }
    }
    
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
      
        switch (section) {
              case 0:  return 2;  break;
              case 1:  return 1;  break;
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
            //default:break;
        }
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    if ([self.className isSubclassOfClass:[ASCourse class]]) {
        
        
                static NSString* identifier = @"detailCell";
                
                if (indexPath.section == 0) {
                
                    ASCourse* course = (ASCourse*)self.objectEntity;
                    ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
                    if (cell == nil)
                    { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]; }
                
                    switch (indexPath.row) {
                            
                        case 0:  cell.label.text = @"Name Course"; cell.textField.text = course.name;    break;
                        case 1:  cell.label.text = @"Subject";     cell.textField.text = course.subject; break;
                        case 2:  cell.label.text = @"Branch";      cell.textField.text = course.branch;  break;

                        default: NSLog(@"Не нашел cell");  break;
                    }
                 return cell;
                                          }
        
        
        
                  if (indexPath.section == 1) {

                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    if (cell == nil)
                    { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]; }
                    cell.textLabel.text = @"tmp1";
                    return cell;
                    }
        
        
                   if (indexPath.section == 2) {
            
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                    if (cell == nil)
                    { cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]; }
                    cell.textLabel.text = @"tmp2";
                    return cell;
                    }
    }
    
    
    
    /////////
    
    if ([self.className isSubclassOfClass:[ASTeacher class]]) {

        static NSString* identifier = @"detailCell";
        
        ASTeacher* teacher = (ASTeacher*)self.objectEntity;
        ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier]; }
        
        if (indexPath.section == 0) {
            
            switch (indexPath.row) {
                    
                case 0:  cell.label.text = @"First Name";  cell.textField.text = teacher.firstName; break;
                case 1:  cell.label.text = @"Last Name";   cell.textField.text = teacher.lastName; break;

                default: NSLog(@"Не нашел cell");  break;
            }
        } else {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            cell.textLabel.text = @"tmp";
            return cell;
            
            
        }
        return cell;
    }
    
    
    /////////////
    
    
    if ([self.className isSubclassOfClass:[ASStudents class]]) {
    
        static NSString* identifier = @"detailCell";
        
        ASStudents* student = (ASStudents*)self.objectEntity;
        ASDetailTableViewCell *cell = (ASDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        { cell = [[ASDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]; }
    
        cell.label.text = @"fsdf";
        if (indexPath.section == 0) {

            switch (indexPath.row) {
                    
                case 0:  cell.label.text = @"First Name"; cell.textField.text = student.firstName; break;
                case 1:  cell.label.text = @"Last Name";  cell.textField.text = student.lastName;  break;
                    
                default: NSLog(@"Не нашел cell");  break;
            }
        } else {
           cell.label.text = @"Email"; cell.textField.text = student.email;
        }
        
      return cell;
    }
    
    
    return nil;
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
