//
//  ASDetailViewController.h
//  HW_41-44_CoreData
//
//  Created by MD on 10.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ASCoreDataViewController.h"
#import "ASDataManager.h"

#import "ASCourse.h"
#import "ASTeacher.h"
#import "ASStudents.h"


@interface ASDetailViewController : UITableViewController <NSFetchedResultsControllerDelegate,
                                                           UITableViewDelegate,
                                                           UITextFieldDelegate>

@property (strong, nonatomic) Class className;
@property (strong, nonatomic) id objectEntity;
@property (strong, nonatomic) id objectEntityNew;


@property (assign, nonatomic) BOOL isSave;
@property (assign, nonatomic) BOOL isEdit;

@property (strong, nonatomic) ASCourse* course;
@property (strong, nonatomic) ASTeacher* teacher;
@property (strong, nonatomic) ASStudents* student;


@property (strong, nonatomic) NSArray* students;
@property (strong, nonatomic) NSArray* teachers;
@property (strong, nonatomic) NSArray* courses;

@property (strong, nonatomic)  UIActivityIndicatorView* indicator;


@end
