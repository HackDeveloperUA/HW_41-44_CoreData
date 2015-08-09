//
//  ASCoreDataViewController.h
//  HW_41-44_CoreData
//
//  Created by MD on 06.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ASCoreDataViewController : UITableViewController <NSFetchedResultsControllerDelegate>


@property (strong, nonatomic) UIBarButtonItem* deleteEntityButton;
@property (strong, nonatomic) UIBarButtonItem* addEntityButton;


@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
