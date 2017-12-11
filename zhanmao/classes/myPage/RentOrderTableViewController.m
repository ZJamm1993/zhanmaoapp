//
//  RentOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderTableViewController.h"
#import "RentOrderTableViewCell.h"
#import "RentOrderDetailTableViewController.h"

@interface RentOrderTableViewController ()<RentOrderTableViewCellDelegate>

@end

@implementation RentOrderTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [OrderTypeDataSource getMyRentOrderByType:self.type token:[UserModel token] page:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
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
    [OrderTypeDataSource getMyRentOrderByType:self.type token:[UserModel token] page:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource addObjectsFromArray:result];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 10;
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 5;
     RentOrderModel* mo=[self.dataSource objectAtIndex:section];
    return 1+mo.goods.count+2; // 1 title + n goods + 1 price + 1 action
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    NSInteger sec=indexPath.section;
    NSInteger srowss=[tableView numberOfRowsInSection:sec];
    NSString* idd=@"RentOrderTableViewCellProductDetail";
    if (row==0) {
        idd=@"RentOrderTableViewCellTimeState";
    }
    else if(row==srowss-1)
    {
        idd=@"RentOrderTableViewCellAction";
    }
    else if(row==srowss-2)
    {
        idd=@"RentOrderTableViewCellPriceDetail";
    }
    
    RentOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:idd forIndexPath:indexPath];
    
    cell.delegate=self;
    
    if (indexPath.section<self.dataSource.count) {
        RentOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
        cell.orderModel=mo;
        
        NSInteger rowForGoods=row-1;
        if (rowForGoods<mo.goods.count) {
            cell.cartModel=[mo.goods objectAtIndex:rowForGoods];
        }
    }
    
    return cell;
}

-(void)rentOrderTableViewCellActionButtonClick:(RentOrderTableViewCell *)cell
{
//    RentOrderModel* rentOrder=cell.orderModel;
//    RentOrderStatus sta=rentOrder.status;
//    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RentOrderDetailTableViewController* rentDetail=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"RentOrderDetailTableViewController"];
    RentOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    rentDetail.rentModel=mo;
    [self.navigationController pushViewController:rentDetail animated:YES];
}

@end
