//
//  CustomOrderDetailTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderDetailTableViewController.h"

@interface CustomOrderDetailTableViewController ()

@end

@implementation CustomOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bottomButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadWithModel];
    [self refresh];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [OrderTypeDataSource getMyCustomOrderDetailById:self.customModel.idd type:self.type token:[UserModel token] success:^(CustomOrderModel *model) {
        if (model.idd.length>0) {
            self.customModel=model;
            [self loadWithModel];
        }
    }];
}

-(void)loadWithModel
{
    [self refreshCustomModel:self.customModel];
    if (self.customModel.order_status==CustomOrderStatusSubmited)
    {
        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
    }
    else
    {
        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
    [self.tableView reloadData];
     [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
}

-(void)refreshCustomModel:(CustomOrderModel *)model
{
    NSLog(@"custom order refresh");
}

-(void)cancelOrder
{
    [OrderTypeDataSource postMyCustomOrderCancelById:self.customModel.idd type:self.type token:[UserModel token] success:^(BOOL result, NSString *msg) {
        if (result) {
            [MBProgressHUD showSuccessMessage:msg];

            self.customModel.order_status=CustomOrderStatusCanceled;
            [self loadWithModel];
            
            [OrderTypeDataSource postOrderStatusChangedNotificationWithOrder:self.customModel];
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
    }];
}

@end
