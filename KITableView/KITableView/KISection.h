//
//  KISection.h
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KICell.h"

@interface KISection : NSObject

@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat heightForFooter;

@property (nonatomic, copy) NSString *titleForHeader;
@property (nonatomic, copy) NSString *titleForFooter;

@property (nonatomic, strong) UIView *viewForHeader;
@property (nonatomic, strong) UIView *viewForFooter;

- (NSArray *)cells;

- (KICell *)cellAtIndex:(NSInteger)index;

- (void)insertCell:(KICell *)cell withIndex:(NSInteger)index;

- (void)setDidSelectRowAtIndexPathBlock:(KITableViewDidSelectRowAtIndexPathBlock)block;
- (KITableViewDidSelectRowAtIndexPathBlock)didSelectRowAtIndexPath;

- (void)setDidDeselectRowAtIndexPathBlock:(KITableViewDidDeselectRowAtIndexPathBlock)block;
- (KITableViewDidDeselectRowAtIndexPathBlock)didDeselectRowAtIndexPath;

@end
