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

@property (nonatomic, copy) KITableViewWillDisplayHeaderViewForSectionBlock tableViewWillDisplayHeaderViewForSectionBlock;
@property (nonatomic, copy) KITableViewWillDisplayFooterViewForSectionBlock tableViewWillDisplayFooterViewForSectionBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingHeaderViewForSectionBlock tableViewDidEndDisplayingHeaderViewForSectionBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingFooterViewForSectionBlock tableViewDidEndDisplayingFooterViewForSectionBlock;
@end

@implementation KISection

#pragma mark - Methods
- (void)appendCell:(KICell *)cell {
    [[self cellListWrapper] addObject:cell];
}

- (void)appendCells:(NSArray *)cells {
    [[self cellListWrapper] addObjectsFromArray:cells];
}

- (void)insertCell:(KICell *)cell withIndex:(NSInteger)index {
    [[self cellListWrapper] insertObject:cell atIndex:index];
}

- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index {
    [[self cellListWrapper] insertObjects:cells
                                atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, cells.count)]];
}

- (void)deleteAllCells {
    [[self cellListWrapper] removeAllObjects];
}

- (void)deleteCellAtIndex:(NSInteger)index {
    [self deleteCellAtIndexes:@[@(index)]];
}

- (void)deleteCellAtIndexes:(NSArray *)indexes {
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
            [[self cellListWrapper] removeObjectAtIndex:index];
        }
    }
}

- (void)deleteCell:(KICell *)cell {
    [self deleteCells:@[cell]];
}

- (void)deleteCells:(NSArray *)cells {
    [[self cellListWrapper] removeObjectsInArray:cells];
}

- (void)reloadAllCells {
    for (KICell *c in self.cells) {
        [self reloadCell:c];
    }
}

- (void)reloadCell:(KICell *)cell {
    NSInteger index = [self.cellList indexOfObject:cell];
    if (index < self.cellList.count) {
        [[self cellListWrapper] replaceObjectAtIndex:index withObject:cell];
    }
}

- (void)reloadCells:(NSArray *)cells {
    for (KICell *c in cells) {
        [self reloadCell:c];
    }
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

- (NSMutableArray *)cellListWrapper {
    return [self mutableArrayValueForKey:@"cellList"];
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
