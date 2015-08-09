//
//  ASStudentsViewController.h
//  HW_41-44_CoreData
//
//  Created by MD on 07.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStudents.h"
#import "ASCoreDataViewController.h"
#import "ASDataManager.h"

@interface ASStudentsViewController : ASCoreDataViewController

- (IBAction)addStudentAction:(id)sender;


//@property (weak, nonatomic) UIBarButtonItem* deleteEntity;
//@property (weak, nonatomic) UIBarButtonItem* addEntity;

// UIBarButtonItem *deleteButton


/*

 UIViewController *fourthViewController = [[UIViewController alloc]init];
 thirdViewController.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
 UINavigationController *fourthNavController = [[UINavigationController alloc]initWithRootViewController:fourthViewController];
 
 tabBar.viewControllers = [[NSArray alloc] initWithObjects:homeNavController, reqNavController, thirdNavController, fourthNavController, nil];
 
*/
@end
