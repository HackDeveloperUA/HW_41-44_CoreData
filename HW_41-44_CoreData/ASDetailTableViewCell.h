//
//  ASDetailTableViewCell.h
//  HW_41-44_CoreData
//
//  Created by MD on 10.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDetailTableViewCell : UITableViewCell
/*
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextField *textField;
*/
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UITextField *textField;

- (IBAction)textFieldValueChanged:(id)sender;

@end
