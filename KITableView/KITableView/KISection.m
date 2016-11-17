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
- (void)insertCell:(KICell *)cell withIndex:(NSInteger)index {
    [self.cellList insertObject:cell atIndex:index];
}

- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index {
    [self.cellList insertObjects:cells
                       atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, cells.count)]];
}

- (void)removeCellAtIndex:(NSInteger)index {
    [self.cellList removeObjectAtIndex:index];
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
