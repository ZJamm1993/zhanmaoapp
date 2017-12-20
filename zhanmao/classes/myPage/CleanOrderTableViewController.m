//
//  CleanOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CleanOrderTableViewController.h"
#import "CleanOrderTableViewCell.h"
#import "CleanOrderDetailTableViewController.h"
#import "PayOrderTableViewController.h"

@interface CleanOrderTableViewController ()

@end

@implementation CleanOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
    // Do any additional setup after loading the view.
}

#pragma datas

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel
{
    for (CleanOrderModel* mo in self.dataSource) {
        if ([mo isMemberOfClass:[orderModel class]]) {
            if ([mo.idd isEqualToString:orderModel.idd]) {
                
                NSInteger row=[self.dataSource indexOfObject:mo];
                [self.dataSource removeObject:mo];
                [self.dataSource insertObject:orderModel atIndex:row];
                
//                if (orderModel.order_status==CleanOrderStatusCanceled) {
//                    [self.dataSource removeObjectAtIndex:row];
//                    [self.tableView reloadData];
//                    return;
//                }
                [self.tableView reloadData];
                return;
            }
        }
    }
}

-(void)refresh
{
    [OrderTypeDataSource getMyCleanOrderByType:self.type token:[UserModel token] page:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        if (result.count>0) {
            self.currentPage=1;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView reloadData];
    }];
}

-(void)loadMore
{
    [OrderTypeDataSource getMyCleanOrderByType:self.type token:[UserModel token] page:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource addObjectsFromArray:result];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView reloadData];
    }];
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CleanOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CleanOrderTableViewCell" forIndexPath:indexPath];
    CleanOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    cell.createTime.text=[mo.post_modified dateString];
    cell.stateTitle.text=[CleanOrderModel cellStateForType:mo.order_status];
    cell.title.text=mo.addr;
    cell.baseFee.text=[NSString stringWithFloat:mo.cost headUnit:@"¥" tailUnit:nil];
    cell.otherFee.text=[NSString stringWithFloat:mo.other_cost headUnit:@"¥" tailUnit:nil];
    cell.totalFee.text=[NSString stringWithFloat:mo.amount headUnit:@"¥" tailUnit:nil];
    
    BOOL shouldPay=mo.pay_status==PayStatusNotYet&&mo.order_status==CleanOrderStatusNotClean;
    
    cell.blueButton.hidden=!shouldPay;
    cell.grayButton.hidden=!cell.blueButton.hidden;
    
    NSString* buttonTitle=[CleanOrderModel cellButtonTitleForType:mo.order_status];
    if (shouldPay) {
        buttonTitle=@"立即付款";
        cell.stateTitle.text=@"待付款";
    }
    [cell.blueButton setTitle:buttonTitle forState:UIControlStateNormal];
    [cell.grayButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    cell.blueButton.tag=indexPath.section;
    [cell.blueButton addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CleanOrderDetailTableViewController* cleanDetail=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"CleanOrderDetailTableViewController"];
    CleanOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    cleanDetail.cleanModel=mo;
    [self.navigationController pushViewController:cleanDetail animated:YES];
}

#pragma mark actions

-(void)payOrder:(UIButton*)btn
{
    NSInteger tag=btn.tag;
    CleanOrderModel* mo=[self.dataSource objectAtIndex:tag];
    if (mo.pay_status==PayStatusNotYet) {
        PayOrderTableViewController* pay=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"PayOrderTableViewController"];
        pay.orderModel=mo.pay;
        pay.orderType=PayOrderTypeClean;
        [self.navigationController pushViewController:pay animated:YES];
    }
}

@end
