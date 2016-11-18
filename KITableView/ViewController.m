//
//  ViewController.m
//  KITableView
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import "ViewController.h"
#import "KITableViewAgent.h"

@interface ViewController ()
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) KITableViewAgent *tableViewAgent;
@end

@implementation ViewController

- (void)haha:(UIButton *)sender {
    
    KISection *s = [self.tableViewAgent sectionAtIndex:0];
    for (KICell *c in s.cells) {
        if (c.height == 0) {
            [c setHeight:40];
        } else {
            [c setHeight:0];
        }
    }
    
    [s reloadAllCells];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tableView = (UITableView *)[self.view viewWithTag:1001];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableViewAgent = [[KITableViewAgent alloc] init];
    [self.tableViewAgent setTableView:self.tableView];
    
    __weak ViewController *weakSelf = self;
    
    KISection *s0 = [[KISection alloc] init];
    UIView *headerView0 = [[UIView alloc] init];
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setBackgroundColor:[UIColor greenColor]];
    [btn0 setFrame:CGRectMake(0, 0, 320, 44)];
    [btn0 addTarget:self action:@selector(haha:) forControlEvents:UIControlEventTouchUpInside];
    [headerView0 addSubview:btn0];
    [s0 setViewForHeader:headerView0];
    [s0 setHeightForHeader:44];
    
    [self.tableViewAgent insertSection:s0 withIndex:0];
    for (int i=0; i<10; i++) {
        KICell *c = [[KICell alloc] init];
        [c setHeight:40];
        [c setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
            }
            [cell setBackgroundColor:[UIColor lightGrayColor]];
            [cell.textLabel setText:[NSString stringWithFormat:@"%d", i]];
            return cell;
        }];
        [c setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            [weakSelf.tableViewAgent deleteCellAtIndexPath:indexPath];
        }];
        [s0 appendCell:c];
    }
    
    
    
    KISection *s1 = [[KISection alloc] init];
    UIView *headerView = [[UIView alloc] init];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setFrame:CGRectMake(0, 0, 320, 44)];
    [btn addTarget:self action:@selector(haha:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    [s1 setViewForHeader:headerView];
    [s1 setHeightForHeader:44];
    
    [self.tableViewAgent insertSection:s1 withIndex:0];
    
    for (int i=0; i<10; i++) {
        KICell *c = [[KICell alloc] init];
        [c setHeight:40];
        [c setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
            }
            [cell setBackgroundColor:[UIColor lightGrayColor]];
            [cell.textLabel setText:[NSString stringWithFormat:@"%d", i]];
            return cell;
        }];
        [c setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            [weakSelf.tableViewAgent deleteCellAtIndexPath:indexPath];
        }];
        [s1 appendCell:c];
    }

//    // cell 1
//    KICell *cell = [[KICell alloc] init];
//    [cell setHeight:100];
//    [cell setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aa"];
//        }
//        [cell.textLabel setText:@"点我可以添加一个 Section"];
//        return cell;
//    }];
//    [cell setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
//        KISection *s = [[KISection alloc] init];
//        [s setHeightForHeader:40];
//        [s setTitleForHeader:@"我是刚刚添加的 Section Header"];
//        [s setHeightForFooter:30];
//        [s setTitleForFooter:@"我是刚刚添加的 Section Footer"];
//        [weakSelf.tableViewAgent appendSecton:s];
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }];
//    
//    
//    // cell 2
//    KICell *cell2 = [[KICell alloc] init];
//    [cell2 setHeight:50];
//    [cell2 setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bb"];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bb"];
//        }
//        [cell.textLabel setText:@"点我可以添加一些 Cell"];
//        return cell;
//    }];
//    [cell2 setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
//        NSMutableArray *cells = [[NSMutableArray alloc] init];
//        for (int i=0; i<20; i++) {
//            KICell *c3 = [[KICell alloc] init];
//            [c3 setHeight:20];
//            [c3 setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
//                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dd"];
//                if (cell == nil) {
//                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dd"];
//                }
//                [cell.textLabel setText:[NSString stringWithFormat:@"我是刚刚添加的 Cell %d", i]];
//                return cell;
//            }];
//            [c3 setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
//                [weakSelf.tableViewAgent deleteCellsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            }];
//            [cells addObject:c3];
//        }
//        
//        [weakSelf.tableViewAgent insertCells:cells
//                               withIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]
//                            withRowAnimation:UITableViewRowAnimationFade];
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }];
//    
//    
//    [self.tableViewAgent appendCell:cell];
//    [self.tableViewAgent appendCell:cell2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
