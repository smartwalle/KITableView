//
//  KICell.h
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell*(^KITableViewCellAtIndexPathBlock) (UITableView *tableView, NSIndexPath *indexPath);

typedef void(^KITableViewDidSelectRowAtIndexPathBlock)   (UITableView *tableView, NSIndexPath *indexPath);
typedef void(^KITableViewDidDeselectRowAtIndexPathBlock) (UITableView *tableView, NSIndexPath *indexPath);

@interface KICell : NSObject

@property (nonatomic, assign) CGFloat height;

- (void)setCellAtIndexPath:(KITableViewCellAtIndexPathBlock)block;
- (KITableViewCellAtIndexPathBlock)cellAtIndexPath;

- (void)setDidSelectRowAtIndexPathBlock:(KITableViewDidSelectRowAtIndexPathBlock)block;
- (KITableViewDidSelectRowAtIndexPathBlock)didSelectRowAtIndexPath;

- (void)setDidDeselectRowAtIndexPathBlock:(KITableViewDidDeselectRowAtIndexPathBlock)block;
- (KITableViewDidDeselectRowAtIndexPathBlock)didDeselectRowAtIndexPath;

@end
