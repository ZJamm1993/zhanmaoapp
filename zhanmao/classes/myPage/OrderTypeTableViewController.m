//
//  OrderTypeTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeTableViewController.h"

@interface OrderTypeTableViewController ()

@end

@implementation OrderTypeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
    
    [self showLoadMoreView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orderTypeChangedNotification:) name:OrderTypeStatusChangedNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==tableView.numberOfSections-1) {
        return 10;
    }
    return 0.001;
}

-(void)orderTypeChangedNotification:(NSNotification*)noti
{
    NSDictionary* us=noti.userInfo;
    OrderTypeBaseModel* model=[us valueForKey:@"order"];
    [self orderStatusChanged:model];
}

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel
{
    NSLog(@"order status changed: %@",orderModel);
}

@end
