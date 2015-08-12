//
//  UIView+SuperTableViewCell.m
//  HW_41-44_CoreData
//
//  Created by MD on 10.08.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "UIView+SuperTableViewCell.h"

@implementation UIView (SuperTableViewCell)

-(UITableViewCell*) superTableViewCell {
    
    if ([self isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superTableViewCell];
}

@end
