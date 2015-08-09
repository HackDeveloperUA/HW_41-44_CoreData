//
//  ASTeacher.h
//  HW_41-44_CoreData
//
//  Created by MD on 09.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import "NSManagedObject.h"

@class ASCourse;

@interface ASTeacher : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet *courses;
@end

@interface ASTeacher (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(ASCourse *)value;
- (void)removeCoursesObject:(ASCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
