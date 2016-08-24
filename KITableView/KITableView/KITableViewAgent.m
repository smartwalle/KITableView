//
//  KITableViewAgent.m
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import "KITableViewAgent.h"

@interface KITableViewAgent ()
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) KITableViewDidSelectRowAtIndexPathBlock   tableViewDidSelectRowAtIndexPathBlock;
@property (nonatomic, copy) KITableViewDidDeselectRowAtIndexPathBlock tableViewDidDeselectRowAtIndexPathBlock;
@end

@implementation KITableViewAgent

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self.dataSource objectAtIndex:indexPath.section];
    KICell *cell = [s cellAtIndex:indexPath.row];
    return [cell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [s heightForHeader];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [s heightForFooter];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [s viewForHeader];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [s viewForFooter];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self.dataSource objectAtIndex:indexPath.section];
    KICell *cell = [s cellAtIndex:indexPath.row];
    
    KITableViewDidSelectRowAtIndexPathBlock block = [cell didSelectRowAtIndexPath];
    
    if (block == nil) {
        block = [s didSelectRowAtIndexPath];
    }
    
    if (block == nil) {
        block = [self tableViewDidSelectRowAtIndexPathBlock];
    }
    
    if (block != nil) {
        block(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self.dataSource objectAtIndex:indexPath.section];
    KICell *cell = [s cellAtIndex:indexPath.row];
    
    KITableViewDidSelectRowAtIndexPathBlock block = [cell didDeselectRowAtIndexPath];
    
    if (block == nil) {
        block = [s didDeselectRowAtIndexPath];
    }
    
    if (block == nil) {
        block = [self tableViewDidDeselectRowAtIndexPathBlock];
    }
    
    if (block != nil) {
        block(tableView, indexPath);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [[s cells] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KICell *c = [self cellAtIndexPath:indexPath];
    
    KITableViewCellAtIndexPathBlock block = [c cellAtIndexPath];
    if (block == nil) {
        return nil;
    }
    return block(tableView, indexPath);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [s titleForHeader];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    KISection *s = [self.dataSource objectAtIndex:section];
    return [s titleForFooter];
}

#pragma mark - Methods 
- (KICell *)cellAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self sectionAtIndex:indexPath.section];
    KICell *cell = [[s cells] objectAtIndex:indexPath.row];
    return cell;
}

- (KISection *)sectionAtIndex:(NSInteger)index {
    if (index >= self.dataSource.count) {
        return nil;
    }
    KISection *s = [self.dataSource objectAtIndex:index];
    return s;
}

- (void)appendSecton:(KISection *)section {
    NSInteger index = self.dataSource.count;
    [self insertSection:section withIndex:index];
}

- (void)insertSection:(KISection *)section withIndex:(NSInteger)index {
    [self insertSection:section withIndex:index withRowAnimation:UITableViewRowAnimationNone];
}

- (void)insertSection:(KISection *)section withIndex:(NSInteger)index withRowAnimation:(UITableViewRowAnimation)animation {
    if (section == nil) {
        return ;
    }
    [self.dataSource insertObject:section atIndex:index];
    [self.tableView beginUpdates];
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:index]
                  withRowAnimation:animation];
    [self.tableView endUpdates];
}


- (void)appendCell:(KICell *)cell {
    NSInteger section = self.dataSource.count - 1;
    section = MAX(section, 0);
    [self appendCell:cell withSection:section];
}

- (void)insertCell:(KICell *)cell withIndexPath:(NSIndexPath *)indexPath {
    [self insertCell:cell
       withIndexPath:indexPath
    withRowAnimation:UITableViewRowAnimationNone];
}

- (void)insertCell:(KICell *)cell withIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    if (cell == nil || indexPath == nil) {
        return;
    }
    
    [self insertCells:@[cell] withIndexPath:indexPath withRowAnimation:animation];
}

- (void)appendCell:(KICell *)cell withSection:(NSInteger)section {
    [self appendCell:cell withSection:section withRowAnimation:UITableViewRowAnimationNone];
}

- (void)appendCell:(KICell *)cell withSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    if (cell == nil) {
        return ;
    }
    [self appendCells:@[cell] withSection:section withRowAnimation:animation];
}

- (void)appendCells:(NSArray *)cells {
    NSInteger section = self.dataSource.count - 1;
    section = MAX(section, 0);
    [self appendCells:cells withSection:section];
}
     
- (void)appendCells:(NSArray *)cells withSection:(NSInteger)section {
    [self appendCells:cells withSection:section withRowAnimation:UITableViewRowAnimationNone];
}

- (void)appendCells:(NSArray *)cells withSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)animation {
    NSInteger row = 0;
    KISection *s = [self sectionAtIndex:section];
    if (s != nil) {
        row = [[s cells] count];
    }
    [self insertCells:cells
        withIndexPath:[NSIndexPath indexPathForRow:row inSection:section]
     withRowAnimation:animation];
}

- (void)insertCells:(NSArray *)cells withIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    if (cells == nil || cells.count == 0 || indexPath == nil) {
        return;
    }
    
    BOOL sectionExists = YES;
    
    NSInteger section = indexPath.section;
    KISection *s = [self sectionAtIndex:section];
    if (s == nil) {
        s = [[KISection alloc] init];
        [self.dataSource addObject:s];
        sectionExists = NO;
    }
    
    [s insertCells:cells withIndex:indexPath.row];
    
    [self.tableView beginUpdates];
    if (sectionExists) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        for (int i=0; i<cells.count; i++) {
            NSIndexPath *temp = [NSIndexPath indexPathForRow:i+indexPath.row inSection:section];
            [indexPaths addObject:temp];
        }
        [self.tableView insertRowsAtIndexPaths:indexPaths
                              withRowAnimation:animation];
    } else {
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:section]
                      withRowAnimation:animation];
    }
    [self.tableView endUpdates];
}

- (void)deleteCellsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSArray *newIndexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *indexPath1 = (NSIndexPath *)obj1;
        NSIndexPath *indexPath2 = (NSIndexPath *)obj2;
        
        if (indexPath1.row > indexPath2.row) {
            return NSOrderedAscending;
        } else if (indexPath1.row < indexPath2.row) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    for (NSIndexPath *indexPath in newIndexPaths) {
        KISection *s = [self.dataSource objectAtIndex:indexPath.section];
        if (s != nil) {
            [s removeCellAtIndex:indexPath.row];
        }
    }
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:newIndexPaths withRowAnimation:animation];
    [self.tableView endUpdates];
}

#pragma mark - Getters & Setters
- (void)setTableView:(UITableView *)tableView {
    _tableView = tableView;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView reloadData];
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)setDidSelectRowAtIndexPathBlock:(KITableViewDidSelectRowAtIndexPathBlock)block {
    [self setTableViewDidSelectRowAtIndexPathBlock:block];
}

- (void)setDidDeselectRowAtIndexPathBlock:(KITableViewDidDeselectRowAtIndexPathBlock)block {
    [self setTableViewDidDeselectRowAtIndexPathBlock:block];
}

@end
