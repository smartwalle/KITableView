//
//  KISection.m
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import "KISection.h"

@interface KISection ()
@property (nonatomic, strong) NSMutableArray *cellList;

@property (nonatomic, copy) KITableViewDidSelectRowAtIndexPathBlock   tableViewDidSelectRowAtIndexPathBlock;
@property (nonatomic, copy) KITableViewDidDeselectRowAtIndexPathBlock tableViewDidDeselectRowAtIndexPathBlock;
@end

@implementation KISection

#pragma mark - Methods
- (void)insertCell:(KICell *)cell withIndex:(NSInteger)index {
    [self.cellList insertObject:cell atIndex:index];
}

- (NSArray *)cells {
    return [self cellList];
}

- (KICell *)cellAtIndex:(NSInteger)index {
    return [self.cellList objectAtIndex:index];
}

#pragma mark - Getters & Setters
- (NSMutableArray *)cellList {
    if (_cellList == nil) {
        _cellList = [[NSMutableArray alloc] init];
    }
    return _cellList;
}

- (void)setDidSelectRowAtIndexPathBlock:(KITableViewDidSelectRowAtIndexPathBlock)block {
    [self setTableViewDidSelectRowAtIndexPathBlock:block];
}

- (KITableViewDidSelectRowAtIndexPathBlock)didSelectRowAtIndexPath {
    return self.tableViewDidSelectRowAtIndexPathBlock;
}

- (void)setDidDeselectRowAtIndexPathBlock:(KITableViewDidDeselectRowAtIndexPathBlock)block {
    [self setTableViewDidDeselectRowAtIndexPathBlock:block];
}

- (KITableViewDidDeselectRowAtIndexPathBlock)didDeselectRowAtIndexPath {
    return self.tableViewDidDeselectRowAtIndexPathBlock;
}

@end
