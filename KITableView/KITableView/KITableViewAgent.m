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

@property (nonatomic, copy) KITableViewWillDisplayCellForRowAtIndexPathBlock      tableViewWillDisplayCellForRowAtIndexPathBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingCellForRowAtIndexPathBlock tableViewDidEndDisplayingCellForRowAtIndexPathBlock;

@property (nonatomic, copy) KITableViewWillDisplayHeaderViewForSectionBlock tableViewWillDisplayHeaderViewForSectionBlock;
@property (nonatomic, copy) KITableViewWillDisplayFooterViewForSectionBlock tableViewWillDisplayFooterViewForSectionBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingHeaderViewForSectionBlock tableViewDidEndDisplayingHeaderViewForSectionBlock;
@property (nonatomic, copy) KITableViewDidEndDisplayingFooterViewForSectionBlock tableViewDidEndDisplayingFooterViewForSectionBlock;

@end

@implementation KITableViewAgent

#pragma mark - Lifecycle
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"dataSource"];
}

- (instancetype)init {
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isKindOfClass:[KISection class]]) {
        NSInteger section = [self.dataSource indexOfObject:object];
        
        if ([keyPath isEqualToString:@"cellList"]) {
            NSNumber *kind = change[NSKeyValueChangeKindKey];
            NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
            
            switch (kind.integerValue) {
                case NSKeyValueChangeSetting:
                    break;
                case NSKeyValueChangeInsertion: {
                    [self.tableView beginUpdates];
                    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
                    for (NSInteger i=indexes.firstIndex; i<= indexes.lastIndex; i++) {
                        NSIndexPath *temp = [NSIndexPath indexPathForRow:i inSection:section];
                        [indexPaths addObject:temp];
                    }
                    [self.tableView insertRowsAtIndexPaths:indexPaths
                                          withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }
                    break;
                case NSKeyValueChangeRemoval: {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexes.firstIndex inSection:section];
                    [self.tableView beginUpdates];
                    [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }
                    break;
                case NSKeyValueChangeReplacement: {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexes.firstIndex inSection:section];
                    [self.tableView beginUpdates];
                    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                          withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }
                    break;
                default:
                    break;
            }
        }
    } else if (object == self) {
        if ([keyPath isEqualToString:@"dataSource"]) {
            NSNumber *kind = change[NSKeyValueChangeKindKey];
            NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
            
            switch (kind.integerValue) {
                case NSKeyValueChangeSetting:
                    break;
                case NSKeyValueChangeInsertion: {
                    [self.tableView beginUpdates];
                    [self.tableView insertSections:indexes
                                  withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }
                    break;
                case NSKeyValueChangeRemoval: {
                    [self.tableView beginUpdates];
                    [self.tableView deleteSections:indexes
                                  withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                }
                    break;
                case NSKeyValueChangeReplacement:
                    break;
                default:
                    break;
            }
        }
    }
}


#pragma mark - UITableViewDelegate

// Display customization
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self sectionAtIndex:indexPath.section];
    KICell *c = [s cellAtIndex:indexPath.row];
    KITableViewWillDisplayCellForRowAtIndexPathBlock block = [c willDisplayCellForRowAtIndexPathBlock];
    if (block == nil) {
        block = [self tableViewWillDisplayCellForRowAtIndexPathBlock];
    }
    if (block != nil) {
        block(tableView, cell, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    KITableViewWillDisplayHeaderViewForSectionBlock block = [s willDisplayHeaderViewForSectionBlock];
    if (block == nil) {
        block = [self tableViewWillDisplayHeaderViewForSectionBlock];
    }
    if (block != nil) {
        block(tableView, view, section);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    KITableViewWillDisplayFooterViewForSectionBlock block = [s willDisplayFooterViewForSectionBlock];
    if (block == nil) {
        block = [self tableViewWillDisplayFooterViewForSectionBlock];
    }
    if (block != nil) {
        block(tableView, view, section);
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    KISection *s = [self sectionAtIndex:indexPath.section];
    KICell *c = [s cellAtIndex:indexPath.row];
    KITableViewDidEndDisplayingCellForRowAtIndexPathBlock block = [c didEndDisplayingCellForRowAtIndexPathBlock];
    if (block == nil) {
        block = [self tableViewDidEndDisplayingCellForRowAtIndexPathBlock];
    }
    if (block != nil) {
        block(tableView, cell, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    KITableViewDidEndDisplayingHeaderViewForSectionBlock block = [s didEndDisplayingHeaderViewForSectionBlock];
    if (block == nil) {
        block = [self tableViewDidEndDisplayingHeaderViewForSectionBlock];
    }
    if (block != nil) {
        block(tableView, view, section);
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    KITableViewDidEndDisplayingFooterViewForSectionBlock block = [s didEndDisplayingFooterViewForSectionBlock];
    if (block == nil) {
        block = [self tableViewDidEndDisplayingFooterViewForSectionBlock];
    }
    if (block != nil) {
        block(tableView, view, section);
    }
}

// Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self sectionAtIndex:indexPath.section];
    KICell *cell = [s cellAtIndex:indexPath.row];
    return [cell height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    return [s heightForHeader];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    return [s heightForFooter];
}

// Section header & footer information. Views are preferred over title should you decide to provide both
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    return [s viewForHeader];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    return [s viewForFooter];
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self sectionAtIndex:indexPath.section];
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
    KISection *s = [self sectionAtIndex:indexPath.section];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
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
    KISection *s = [self sectionAtIndex:section];
    return [s titleForHeader];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    KISection *s = [self sectionAtIndex:section];
    return [s titleForFooter];
}

#pragma mark - Methods
- (NSMutableArray *)dataSourceWrapper {
    return [self mutableArrayValueForKey:@"dataSource"];
}

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
    NSInteger section = indexPath.section;
    KISection *s = [self sectionAtIndex:section];
    if (s == nil) {
        s = [[KISection alloc] init];
        [s addObserver:self forKeyPath:@"cellList" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [[self dataSourceWrapper] addObject:s];
    }
    [s insertCells:cells withIndex:indexPath.row];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath {
    KISection *s = [self sectionAtIndex:indexPath.section];
    if (s != nil) {
        [s deleteCellAtIndex:indexPath.row];
    }
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
        KISection *s = [self sectionAtIndex:indexPath.section];
        if (s != nil) {
            [s deleteCellAtIndex:indexPath.row];
        }
    }
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths {
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self.tableView endUpdates];
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
    if ([self.dataSource containsObject:section]) {
        return ;
    }
    
    [section addObserver:self forKeyPath:@"cellList" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [[self dataSourceWrapper] insertObject:section atIndex:index];
}

- (void)removeSection:(KISection *)section {
    [self removeSection:section withRowAnimation:UITableViewRowAnimationFade];
}

- (void)removeSection:(KISection *)section withRowAnimation:(UITableViewRowAnimation)animation {
    if (section != nil) {
        if ([self.dataSource containsObject:section]) {
            [section removeObserver:self forKeyPath:@"cellList"];
            [[self dataSourceWrapper] removeObject:section];
        }
    }
}

- (void)deleteAllSection {
    for (KISection *s in self.dataSource) {
        [s removeObserver:self forKeyPath:@"cellList"];
    }
    [[self dataSourceWrapper] removeAllObjects];
}

- (void)deleteSection:(NSInteger)section {
    if (self.dataSource.count <= section) {
        return;
    }
    [self deleteSections:[NSIndexSet indexSetWithIndex:section]];
}

- (void)deleteSections:(NSIndexSet *)sections {
    [self deleteSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    for (NSInteger i=sections.firstIndex; i<=sections.lastIndex; i++) {
        KISection *s = [self sectionAtIndex:i];
        if (s != nil) {
            [s removeObserver:self forKeyPath:@"cellList"];
        }
    }
    [[self dataSourceWrapper] removeObjectsAtIndexes:sections];
}

- (void)reloadSection:(KISection *)section {
    NSUInteger index = [self.dataSource indexOfObject:section];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self reloadSections:indexSet];
}

- (void)reloadSections:(NSIndexSet *)sections {
    [self reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self.tableView beginUpdates];
    [self.tableView reloadSections:sections withRowAnimation:animation];
    [self.tableView endUpdates];
}

#pragma mark - Getters & Setters
- (void)setTableView:(UITableView *)tableView {
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
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

- (void)setWillDisplayCellForRowAtIndexPathBlock:(KITableViewWillDisplayCellForRowAtIndexPathBlock)block {
    [self setTableViewWillDisplayCellForRowAtIndexPathBlock:block];
}

- (void)setDidEndDisplayingCellForRowAtIndexPathBlock:(KITableViewDidEndDisplayingCellForRowAtIndexPathBlock)block {
    [self setTableViewDidEndDisplayingCellForRowAtIndexPathBlock:block];
}

- (void)setWillDisplayHeaderViewForSectionBlock:(KITableViewWillDisplayHeaderViewForSectionBlock)block {
    [self setTableViewWillDisplayHeaderViewForSectionBlock:block];
}

- (void)setWillDisplayFooterViewForSectionBlock:(KITableViewWillDisplayFooterViewForSectionBlock)block {
    [self setTableViewWillDisplayFooterViewForSectionBlock:block];
}

- (void)setDidEndDisplayingHeaderViewForSectionBlock:(KITableViewDidEndDisplayingHeaderViewForSectionBlock)block {
    [self setTableViewDidEndDisplayingHeaderViewForSectionBlock:block];
}

- (void)setDidEndDisplayingFooterViewForSectionBlock:(KITableViewDidEndDisplayingFooterViewForSectionBlock)block {
    [self setTableViewDidEndDisplayingFooterViewForSectionBlock:block];
}

@end
