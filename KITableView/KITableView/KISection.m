//
//  KISection.m
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import "KISection.h"

@interface KISection ()

@property (nonatomic, strong) KITableViewAction *action;

@property (nonatomic, strong) NSMutableArray *cellList;

@property (nonatomic, copy) KITableViewDidSelectRowAtIndexPathBlock   tableViewDidSelectRowAtIndexPathBlock;
@property (nonatomic, copy) KITableViewDidDeselectRowAtIndexPathBlock tableViewDidDeselectRowAtIndexPathBlock;

@property (nonatomic, copy) KITableViewWillDisplayHeaderViewForSectionBlock tableViewWillDisplayHeaderViewForSectionBlock;
@property (nonatomic, copy) KITableViewWillDisplayFooterViewForSectionBlock tableViewWillDisplayFooterViewForSectionBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingHeaderViewForSectionBlock tableViewDidEndDisplayingHeaderViewForSectionBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingFooterViewForSectionBlock tableViewDidEndDisplayingFooterViewForSectionBlock;
@end

@implementation KISection

#pragma mark - Methods
- (void)postAction:(KITableViewActionType)type indexes:(NSArray *)indexes animation:(UITableViewRowAnimation)animation {
    KITableViewAction *action = [[KITableViewAction alloc] init];
    [action setType:type];
    [action setAnimation:animation];
    action.indexes = indexes;
    [self setAction:action];
}


- (void)appendCell:(KICell *)cell {
    [self appendCells:@[cell]];}

- (void)appendCells:(NSArray *)cells {
    [self.cellList addObjectsFromArray:cells];
    
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    for (NSInteger i=self.cellList.count-cells.count; i<self.cellList.count; i++) {
        [indexes addObject:@(i)];
    }
    [self postAction:KITableViewActionTypeOfInsertion indexes:indexes animation:UITableViewRowAnimationAutomatic];
}

- (void)insertCell:(KICell *)cell withIndex:(NSInteger)index {
    [self.cellList insertObject:cell atIndex:index];
    
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    [indexes addObject:@(index)];
    [self postAction:KITableViewActionTypeOfInsertion indexes:indexes animation:UITableViewRowAnimationAutomatic];
}

- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index {
    [self insertCells:cells withIndex:index withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index withRowAnimation:(UITableViewRowAnimation)animation {
    [self.cellList insertObjects:cells
                       atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, cells.count)]];
    
    NSInteger count = index + cells.count;
    
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    for (int i=index; i<count; i++) {
        [indexes addObject:@(i)];
    }
    [self postAction:KITableViewActionTypeOfInsertion indexes:indexes animation:animation];
}

- (void)deleteAllCells {
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    
    for (int i=0; i<self.cellList.count; i++) {
        [indexes addObject:@(i)];
    }
    [self deleteCellAtIndexes:indexes];
}

- (void)deleteCellAtIndex:(NSInteger)index {
    [self deleteCellAtIndexes:@[@(index)]];
}

- (void)deleteCellAtIndexes:(NSArray *)indexes {
    [self deleteCellAtIndexes:indexes withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteCellAtIndexes:(NSArray *)indexes withRowAnimation:(UITableViewRowAnimation)animation {
    NSArray *newIndexes = [indexes sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSUInteger index1 = [(NSNumber *)obj1 unsignedIntegerValue];
        NSUInteger index2 = [(NSNumber *)obj2 unsignedIntegerValue];
        
        if (index1 > index2) {
            return NSOrderedAscending;
        } else if (index1 < index2) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    for (NSInteger i=0; i<newIndexes.count; i++) {
        NSInteger index = [newIndexes[i] integerValue];
        if (index < self.cellList.count) {
            [self.cellList removeObjectAtIndex:index];
        }
    }
    [self postAction:KITableViewActionTypeOfRemoval indexes:newIndexes animation:animation];
}

- (void)deleteCell:(KICell *)cell {
    [self deleteCells:@[cell]];
}

- (void)deleteCells:(NSArray *)cells {
    [self deleteCells:cells withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteCells:(NSArray *)cells withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    for (KICell *cell in cells) {
        if ([self.cellList containsObject:cell]) {
            [indexes addObject:@([self.cellList indexOfObject:cell])];
        }
    }
    [self.cellList removeObjectsInArray:cells];
    [self postAction:KITableViewActionTypeOfRemoval indexes:indexes animation:animation];
}

- (void)reloadAllCells {
    [self reloadCells:self.cellList];
}

- (void)reloadCell:(KICell *)cell {
    [self reloadCells:@[cell]];
}

- (void)reloadCells:(NSArray *)cells {
    [self reloadCells:cells withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)reloadCells:(NSArray *)cells withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *indexes = [[NSMutableArray alloc] init];
    for (KICell *cell in cells) {
        if ([self.cellList containsObject:cell]) {
            [indexes addObject:@([self.cellList indexOfObject:cell])];
        }
    }
    [self postAction:KITableViewActionTypeOfReplacement indexes:indexes animation:animation];
}

- (NSArray *)cells {
    return [self cellList];
}

- (KICell *)cellAtIndex:(NSInteger)index {
    if (self.cellList.count > index) {
        return [self.cellList objectAtIndex:index];
    }
    return nil;
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

- (void)setWillDisplayHeaderViewForSectionBlock:(KITableViewWillDisplayHeaderViewForSectionBlock)block {
    [self setTableViewWillDisplayHeaderViewForSectionBlock:block];
}

- (KITableViewWillDisplayHeaderViewForSectionBlock)willDisplayHeaderViewForSectionBlock {
    return self.tableViewWillDisplayHeaderViewForSectionBlock;
}

- (void)setWillDisplayFooterViewForSectionBlock:(KITableViewWillDisplayFooterViewForSectionBlock)block {
    [self setTableViewWillDisplayFooterViewForSectionBlock:block];
}

- (KITableViewWillDisplayFooterViewForSectionBlock)willDisplayFooterViewForSectionBlock {
    return self.tableViewWillDisplayFooterViewForSectionBlock;
}

- (void)setDidEndDisplayingHeaderViewForSectionBlock:(KITableViewDidEndDisplayingHeaderViewForSectionBlock)block {
    [self setTableViewDidEndDisplayingHeaderViewForSectionBlock:block];
}

- (KITableViewDidEndDisplayingHeaderViewForSectionBlock)didEndDisplayingHeaderViewForSectionBlock {
    return self.tableViewDidEndDisplayingHeaderViewForSectionBlock;
}

- (void)setDidEndDisplayingFooterViewForSectionBlock:(KITableViewDidEndDisplayingFooterViewForSectionBlock)block {
    [self setTableViewDidEndDisplayingFooterViewForSectionBlock:block];
}

- (KITableViewDidEndDisplayingFooterViewForSectionBlock)didEndDisplayingFooterViewForSectionBlock {
    return self.tableViewDidEndDisplayingFooterViewForSectionBlock;
}

@end
