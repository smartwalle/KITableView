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

typedef void(^KITableViewWillDisplayHeaderViewForSectionBlock) (UITableView *tableView, UIView *headerView, NSInteger section);
typedef void(^KITableViewWillDisplayFooterViewForSectionBlock) (UITableView *tableView, UIView *footerView, NSInteger section);

typedef void(^KITableViewDidEndDisplayingHeaderViewForSectionBlock) (UITableView *tableView, UIView *headerView, NSInteger section);
typedef void(^KITableViewDidEndDisplayingFooterViewForSectionBlock) (UITableView *tableView, UIView *footerView, NSInteger section);

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
- (void)insertCells:(NSArray *)cells withIndex:(NSInteger)index;

- (void)removeCellAtIndex:(NSInteger)index;


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
