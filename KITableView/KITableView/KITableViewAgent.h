//
//  KITableViewAgent.h
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KISection.h"
#import "KICell.h"

@interface KITableViewAgent : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

- (KISection *)sectionAtIndex:(NSInteger)index;

// 添加 Cell
- (void)appendCell:(KICell *)cell;

- (void)insertCell:(KICell *)cell withIndexPath:(NSIndexPath *)indexPath;
- (void)insertCell:(KICell *)cell withIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

- (void)appendCell:(KICell *)cell withSection:(NSInteger)section;
- (void)appendCell:(KICell *)cell withSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

- (void)appendCells:(NSArray *)cells;
- (void)appendCells:(NSArray *)cells withSection:(NSInteger)section;
- (void)appendCells:(NSArray *)cells withSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertCells:(NSArray *)cells withIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;

// 删除 Cell
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteCellsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

// 重新加载 Cell
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths;
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

// 添加 Section
- (void)appendSecton:(KISection *)section;

- (void)insertSection:(KISection *)section withIndex:(NSInteger)index;
- (void)insertSection:(KISection *)section withIndex:(NSInteger)index withRowAnimation:(UITableViewRowAnimation)animation;

// 删除 Section
- (void)removeSection:(KISection *)section;
- (void)removeSection:(KISection *)section withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteAllSection;
- (void)deleteSection:(NSInteger)section;
- (void)deleteSections:(NSIndexSet *)sections;
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

// 重新加载 Section
- (void)reloadSection:(KISection *)section;
- (void)reloadSections:(NSIndexSet *)sections;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;


- (void)setDidSelectRowAtIndexPathBlock:(KITableViewDidSelectRowAtIndexPathBlock)block;
- (void)setDidDeselectRowAtIndexPathBlock:(KITableViewDidDeselectRowAtIndexPathBlock)block;


- (void)setWillDisplayCellForRowAtIndexPathBlock:(KITableViewWillDisplayCellForRowAtIndexPathBlock)block;
- (void)setDidEndDisplayingCellForRowAtIndexPathBlock:(KITableViewDidEndDisplayingCellForRowAtIndexPathBlock)block;

- (void)setWillDisplayHeaderViewForSectionBlock:(KITableViewWillDisplayHeaderViewForSectionBlock)block;
- (void)setWillDisplayFooterViewForSectionBlock:(KITableViewWillDisplayFooterViewForSectionBlock)block;

- (void)setDidEndDisplayingHeaderViewForSectionBlock:(KITableViewDidEndDisplayingHeaderViewForSectionBlock)block;
- (void)setDidEndDisplayingFooterViewForSectionBlock:(KITableViewDidEndDisplayingFooterViewForSectionBlock)block;

@end
