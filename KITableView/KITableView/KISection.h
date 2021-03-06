//
//  KISection.h
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KICell.h"

typedef NS_ENUM(NSInteger, KISecionActionType) {
    KISecionActionTypeOfInsertRows = 0x01,
    KISecionActionTypeOfDeleteRows = 0x02,
    KISecionActionTypeOfReloadRows = 0x03
};

typedef void(^KITableViewWillDisplayHeaderViewForSectionBlock) (UITableView *tableView, UIView *headerView, NSInteger section);
typedef void(^KITableViewWillDisplayFooterViewForSectionBlock) (UITableView *tableView, UIView *footerView, NSInteger section);

typedef void(^KITableViewDidEndDisplayingHeaderViewForSectionBlock) (UITableView *tableView, UIView *headerView, NSInteger section);
typedef void(^KITableViewDidEndDisplayingFooterViewForSectionBlock) (UITableView *tableView, UIView *footerView, NSInteger section);

@class KISection;
@protocol KISectionDelegate <NSObject>
- (void)section:(KISection *)section didUpdateRowsAtIndexes:(NSArray *)indexes type:(KISecionActionType)type animation:(UITableViewRowAnimation)animation;
@end

@interface KISection : NSObject

@property (nonatomic, weak) id<KISectionDelegate> delegate;

@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat heightForFooter;

@property (nonatomic, copy) NSString *titleForHeader;
@property (nonatomic, copy) NSString *titleForFooter;

@property (nonatomic, strong) UIView *viewForHeader;
@property (nonatomic, strong) UIView *viewForFooter;

- (NSArray *)cells;

- (KICell *)cellAtIndex:(NSInteger)index;

- (void)appendCell:(KICell *)cell;
- (void)appendCells:(NSArray *)cells;

- (void)insertCell:(KICell *)cell withIndex:(NSInteger)index;
- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index;
- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteAllCells;
- (void)deleteCellAtIndex:(NSInteger)index;
- (void)deleteCellAtIndexes:(NSArray *)indexes; // indexes 为需要删除 index 的列表，如 @[@(3), @(1), @(2)]
- (void)deleteCellAtIndexes:(NSArray *)indexes withRowAnimation:(UITableViewRowAnimation)animation;

- (void)deleteCell:(KICell *)cell;
- (void)deleteCells:(NSArray *)cells;
- (void)deleteCells:(NSArray *)cells withRowAnimation:(UITableViewRowAnimation)animation;

- (void)reloadAllCells;
- (void)reloadCell:(KICell *)cell;
- (void)reloadCells:(NSArray *)cells;
- (void)reloadCells:(NSArray *)cells withRowAnimation:(UITableViewRowAnimation)animation;

- (void)setDidSelectRowAtIndexPathBlock:(KITableViewDidSelectRowAtIndexPathBlock)block;
- (KITableViewDidSelectRowAtIndexPathBlock)didSelectRowAtIndexPath;

- (void)setDidDeselectRowAtIndexPathBlock:(KITableViewDidDeselectRowAtIndexPathBlock)block;
- (KITableViewDidDeselectRowAtIndexPathBlock)didDeselectRowAtIndexPath;

- (void)setWillDisplayHeaderViewForSectionBlock:(KITableViewWillDisplayHeaderViewForSectionBlock)block;
- (KITableViewWillDisplayHeaderViewForSectionBlock)willDisplayHeaderViewForSectionBlock;

- (void)setWillDisplayFooterViewForSectionBlock:(KITableViewWillDisplayFooterViewForSectionBlock)block;
- (KITableViewWillDisplayFooterViewForSectionBlock)willDisplayFooterViewForSectionBlock;

- (void)setDidEndDisplayingHeaderViewForSectionBlock:(KITableViewDidEndDisplayingHeaderViewForSectionBlock)block;
- (KITableViewDidEndDisplayingHeaderViewForSectionBlock)didEndDisplayingHeaderViewForSectionBlock;

- (void)setDidEndDisplayingFooterViewForSectionBlock:(KITableViewDidEndDisplayingFooterViewForSectionBlock)block;
- (KITableViewDidEndDisplayingFooterViewForSectionBlock)didEndDisplayingFooterViewForSectionBlock;

@end
