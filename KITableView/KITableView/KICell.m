//
//  KICell.m
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import "KICell.h"

@interface KICell ()
@property (nonatomic, copy) KITableViewCellAtIndexPathBlock           tableViewCellAtIndexPathBlock;
@property (nonatomic, copy) KITableViewDidSelectRowAtIndexPathBlock   tableViewDidSelectRowAtIndexPathBlock;
@property (nonatomic, copy) KITableViewDidDeselectRowAtIndexPathBlock tableViewDidDeselectRowAtIndexPathBlock;
@end

@implementation KICell

- (void)setCellAtIndexPath:(KITableViewCellAtIndexPathBlock)block {
    [self setTableViewCellAtIndexPathBlock:block];
}

- (KITableViewCellAtIndexPathBlock)cellAtIndexPath {
    return self.tableViewCellAtIndexPathBlock;
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
