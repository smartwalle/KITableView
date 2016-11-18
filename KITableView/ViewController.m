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
    
    KISection *s = [self.tableViewAgent sectionAtIndex:sender.tag];
    for (KICell *c in s.cells) {
        if (c.height == 0) {
            [c setHeight:40];
            
        } else {
            [c setHeight:0];
        }
    }
    [s reloadCells:s.cells];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tableView = (UITableView *)[self.view viewWithTag:1001];
    [self.tableView setTableFooterView:[UIView new]];
    
    self.tableViewAgent = [[KITableViewAgent alloc] init];
    [self.tableViewAgent setTableView:self.tableView];
    
    __weak ViewController *weakSelf = self;
    
    KISection *s0 = [[KISection alloc] init];
    UIView *headerView0 = [[UIView alloc] init];
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn0 setBackgroundColor:[UIColor greenColor]];
    [btn0 setFrame:CGRectMake(0, 0, 320, 44)];
    [btn0 setTag:0];
    [btn0 addTarget:self action:@selector(haha:) forControlEvents:UIControlEventTouchUpInside];
    [headerView0 addSubview:btn0];
    [s0 setViewForHeader:headerView0];
    [s0 setHeightForHeader:44];
    
    [self.tableViewAgent insertSection:s0 withIndex:0];
    
    
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (int i=0; i<20; i++) {
        KICell *c = [[KICell alloc] init];
        [c setHeight:40];
        [c setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
            }
            [cell setBackgroundColor:[UIColor whiteColor]];
            [cell.textLabel setText:[NSString stringWithFormat:@"%d", i]];
            return cell;
        }];
        [c setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            [s0 deleteCellAtIndexes:@[@(indexPath.row)] withRowAnimation:UITableViewRowAnimationLeft];
        }];
        
        [cells addObject:c];
    }
    
    [s0 appendCells:cells];
    
    
    KISection *s1 = [[KISection alloc] init];
    UIView *headerView = [[UIView alloc] init];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTag:1];
    [btn setFrame:CGRectMake(0, 0, 320, 44)];
    [btn addTarget:self action:@selector(haha:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    [s1 setViewForHeader:headerView];
    [s1 setHeightForHeader:44];
    
    [self.tableViewAgent insertSection:s1 withIndex:1];
    for (int i=0; i<20; i++) {
        KICell *c = [[KICell alloc] init];
        [c setHeight:40];
        [c setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
            }
            [cell setBackgroundColor:[UIColor whiteColor]];
            [cell.textLabel setText:[NSString stringWithFormat:@"%d", i]];
            return cell;
        }];
        [c setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            [weakSelf.tableViewAgent deleteSection:1 withRowAnimation:UITableViewRowAnimationFade];
        }];
        [s1 insertCell:c withIndex:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
