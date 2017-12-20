//
//  CustomOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/8.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderTableViewController.h"
#import "CustomOrderTableViewCell.h"
#import "CustomOrderDetailTableViewController.h"

@interface CustomOrderTableViewController ()

@end

@implementation CustomOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh];
    // Do any additional setup after loading the view.
}

#pragma mark datas

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel
{
    for (CustomOrderModel* mo in self.dataSource) {
        if ([mo isMemberOfClass:[orderModel class]]) {
            if ([mo.idd isEqualToString:orderModel.idd]) {
                if (mo.type==orderModel.type) {
                    mo.order_status=orderModel.order_status;
                    [self.tableView reloadData];
                    return;
                }
            }
        }
    }
}

-(void)refresh
{
    [OrderTypeDataSource getMyCustomOrderByType:self.type token:[UserModel token] page:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
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
    [OrderTypeDataSource getMyCustomOrderByType:self.type token:[UserModel token] page:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
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
    CustomOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CustomOrderTableViewCell" forIndexPath:indexPath];
    
    cell.titleName.text=[CustomOrderModel cellOrderTypeNameForType:self.type];
    cell.idName.text=[CustomOrderModel cellOrderIdNameForType:self.type];
    cell.dateName.text=[CustomOrderModel cellOrderDateNameForType:self.type];
    cell.UnitName.text=[CustomOrderModel cellOrderUnitNameForType:self.type];
    
    //do your self
    CustomOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    NSDictionary* dic=mo.dictionary;
    
    NSString* cancelString=@"";
    NSString* titleString=@"";
    NSString* orderIdString=@"";
    NSString* orderDateString=@"";
    NSString* orderUnitString=@"";
    
    if (self.type==CustomOrderTypeZhuchang) {
        titleString=[dic valueForKey:@"exhibition_name"];
        orderIdString=[dic valueForKey:@"order_num"];
        orderDateString=[dic valueForKey:@"time"];
        orderUnitString=[dic valueForKey:@"organizer"];
    }
    else if (self.type==CustomOrderTypeZhantai) {
        titleString=[dic valueForKey:@"exhibition_name"];
        orderIdString=[dic valueForKey:@"order_num"];
        orderDateString=[dic valueForKey:@"scalebooth_date"];
        orderUnitString=[dic valueForKey:@"exhibitors"];
    }
    else if (self.type==CustomOrderTypeZhanting) {
        titleString=[dic valueForKey:@"name"];
        orderIdString=[dic valueForKey:@"order_num"];
        orderDateString=[dic valueForKey:@"completion_date"];
        orderUnitString=[dic valueForKey:@"design_unit"];
    }
    else if (self.type==CustomOrderTypeWutai) {
        titleString=[dic valueForKey:@"name"];
        orderIdString=[dic valueForKey:@"order_num"];
        orderDateString=[dic valueForKey:@"date"];
        orderUnitString=[dic valueForKey:@"organizer"];
    }
    else if (self.type==CustomOrderTypeYanyi) {
        titleString=[dic valueForKey:@"name"];
        orderIdString=[dic valueForKey:@"order_num"];
        orderDateString=[dic valueForKey:@"date"];
        orderUnitString=[dic valueForKey:@"organizer"];
    }
    else if (self.type==CustomOrderTypeYaoyue) {
        titleString=[dic valueForKey:@"exhibition_name"];
        orderIdString=[dic valueForKey:@"order_num"];
        orderDateString=[dic valueForKey:@"date"];
        orderUnitString=[dic valueForKey:@"organizer"];
    }
    
    cancelString=mo.order_status==CustomOrderStatusCanceled?@"已取消":@"";
    
    cell.customOrderId.text=orderIdString;
    cell.customOrderDate.text=[[orderDateString description]dateString];
    cell.customOrderUnit.text=orderUnitString;
    cell.titleValue.text=titleString;
    cell.cancelLabel.text=cancelString;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    
    NSString* vcid=@"";
    
    if (self.type==CustomOrderTypeZhuchang) {
        vcid=@"ZhuchangOrderDetailViewController";
    }
    else if (self.type==CustomOrderTypeZhantai) {
        vcid=@"ZhantaiOrderDetailViewController";
    }
    else if (self.type==CustomOrderTypeZhanting) {
        vcid=@"ZhantingOrderDetailViewController";
    }
    else if (self.type==CustomOrderTypeWutai) {
        vcid=@"WutaiOrderDetailViewController";
    }
    else if (self.type==CustomOrderTypeYanyi) {
        vcid=@"YanyiOrderDetailViewController";
    }
    else if (self.type==CustomOrderTypeYaoyue) {
        vcid=@"YaoyueOrderDetailViewController";
    }
    
    if(vcid.length>0)
    {
        CustomOrderDetailTableViewController* det=[[UIStoryboard storyboardWithName:@"MyCustomOrder" bundle:nil]instantiateViewControllerWithIdentifier:vcid];
        det.title=[NSString stringWithFormat:@"%@%@",[CustomOrderModel controllerTitleForType:self.type],@"定制订单详情"];
        if ([det isKindOfClass:[CustomOrderDetailTableViewController class]]) {
            det.customModel=mo;
            det.type=self.type;
        }
        [self.navigationController pushViewController:det animated:YES];
    }
}

@end
