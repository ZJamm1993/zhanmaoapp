//
//  TransportOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TransportOrderTableViewController.h"
#import "TransportOrderTableViewCell.h"
#import "TransportOrderDetailTableViewController.h"

@interface TransportOrderTableViewController ()

@end

@implementation TransportOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
    // Do any additional setup after loading the view.
}

#pragma mark datas

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel
{
    for (TransportOrderModel* mo in self.dataSource) {
        if ([mo isMemberOfClass:[orderModel class]]) {
            if ([mo.idd isEqualToString:orderModel.idd]) {
                mo.order_status=orderModel.order_status;
                [self.tableView reloadData];
                return;
            }
        }
    }
}

-(void)refresh
{
    [OrderTypeDataSource getMyTransportOrderByType:self.type token:[UserModel token] page:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
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
    [OrderTypeDataSource getMyTransportOrderByType:self.type token:[UserModel token] page:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
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
    TransportOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"TransportOrderTableViewCell" forIndexPath:indexPath];
    TransportOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    cell.expressName.text=mo.logistics_type;
    cell.expressOrderId.text=mo.order_num;
    cell.sender.text=mo.sender;
    cell.receiver.text=mo.collect;
    cell.cancelString.text=mo.order_status==TransportOrderStatusCancel?@"已取消":@"";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TransportOrderDetailTableViewController* tranDetail=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"TransportOrderDetailTableViewController"];
    TransportOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    tranDetail.transportModel=mo;
    tranDetail.title=[NSString stringWithFormat:@"%@%@",[TransportOrderModel controllerTitleForType:self.type],@"详情"];
    [self.navigationController pushViewController:tranDetail animated:YES];
}

@end
