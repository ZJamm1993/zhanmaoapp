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

@interface CleanOrderTableViewController ()

@end

@implementation CleanOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
    // Do any additional setup after loading the view.
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
    }];
}

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
    cell.totalFee.text=[NSString stringWithFloat:mo.total_cost headUnit:@"¥" tailUnit:nil];
    
    cell.blueButton.hidden=(mo.order_status!=CleanOrderStatusNotPaid);
    cell.grayButton.hidden=!cell.blueButton.hidden;
    
    NSString* buttonTitle=[CleanOrderModel cellButtonTitleForType:mo.order_status];
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

-(void)payOrder:(UIButton*)btn
{
    NSInteger tag=btn.tag;
    CleanOrderModel* mo=[self.dataSource objectAtIndex:tag];
    if (mo.pay_status==PayStatusNotYet&&mo.order_status==CleanOrderStatusNotPaid) {
        NSLog(@"pay clean: %@",mo);
    }
}

@end
