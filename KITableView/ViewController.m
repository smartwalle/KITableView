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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = (UITableView *)[self.view viewWithTag:1001];
    
    self.tableViewAgent = [[KITableViewAgent alloc] init];
    [self.tableViewAgent setTableView:self.tableView];
    
    __weak ViewController *weakSelf = self;
    
    // cell 1
    KICell *cell = [[KICell alloc] init];
    [cell setHeight:100];
    [cell setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aa"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aa"];
        }
        [cell.textLabel setText:@"点我可以添加一个 Section"];
        return cell;
    }];
    [cell setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        KISection *s = [[KISection alloc] init];
        [s setHeightForHeader:40];
        [s setTitleForHeader:@"我是刚刚添加的 Section"];
        [weakSelf.tableViewAgent appendSecton:s];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
    
    // cell 2
    KICell *cell2 = [[KICell alloc] init];
    [cell2 setHeight:50];
    [cell2 setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bb"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bb"];
        }
        [cell.textLabel setText:@"点我可以添加一个 Cell"];
        return cell;
    }];
    [cell2 setDidSelectRowAtIndexPathBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        KICell *c3 = [[KICell alloc] init];
        [c3 setHeight:80];
        [c3 setCellAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dd"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dd"];
            }
            [cell.textLabel setText:@"我是刚刚添加的 Cell"];
            return cell;
        }];
        [weakSelf.tableViewAgent appendCell:c3 withSection:0];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
    
    [self.tableViewAgent appendCell:cell];
    [self.tableViewAgent appendCell:cell2];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
