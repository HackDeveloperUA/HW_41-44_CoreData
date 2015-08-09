//
//  ASCourse.h
//  HW_41-44_CoreData
//
//  Created by MD on 09.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import "NSManagedObject.h"

@class ASStudents, ASTeacher;

@interface ASCourse : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * branch;
@property (nonatomic, retain) NSSet *teachers;
@property (nonatomic, retain) NSSet *students;
@end

@interface ASCourse (CoreDataGeneratedAccessors)

- (void)addTeachersObject:(ASTeacher *)value;
- (void)removeTeachersObject:(ASTeacher *)value;
- (void)addTeachers:(NSSet *)values;
- (void)removeTeachers:(NSSet *)values;

- (void)addStudentsObject:(ASStudents *)value;
- (void)removeStudentsObject:(ASStudents *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
