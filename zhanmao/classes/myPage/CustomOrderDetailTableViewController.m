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

#pragma mark datas

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
    
    //order details
    NSString* headerImage=@"green3point";
    NSString* headerTitle=@"订单已提交";
    NSString* headerDetail=@"请保持手机畅通";
    if (self.customModel.order_status==CustomOrderStatusCanceled) {
        headerImage=@"greenFailure";
        headerTitle=@"订单已取消";
        headerDetail=@"您的订单已经取消";
    }
    else if (self.customModel.order_status==CustomOrderStatusCompleted) {
        headerImage=@"greenSuccess";
        headerTitle=@"订单已完成";
        headerDetail=@"您的订单已经完成";
    }
    
    self.headerStatusCell.image.image=[UIImage imageNamed:headerImage];
    self.headerStatusCell.title.text=headerTitle;
    self.headerStatusCell.detail.text=headerDetail;
    
    //order bottom same contacts...
    NSDictionary* dic=self.customModel.dictionary;
    
    self.addressee.text=[dic valueForKey:@"addressee"];
    self.o_phone.text=[dic valueForKey:@"o_phone"];
    self.m_phone.text=[dic valueForKey:@"m_phone"];
    self.email.text=[dic valueForKey:@"email"];
    self.province_city_district.text=[NSString stringWithFormat:@"%@%@%@",[dic valueForKey:@"province"],[dic valueForKey:@"city"],[dic valueForKey:@"district"]];
    self.address.text=[dic valueForKey:@"address"];
    
    //order status
    
    if (self.customModel.order_status==CustomOrderStatusSubmited)
    {
//        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
        [self setBottomBarHidden:NO];
    }
    else
    {
//        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
        [self setBottomBarHidden:YES];
    }
    [self.tableView reloadData];
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
}

#pragma mark tableviews

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark actions

-(void)refreshCustomModel:(CustomOrderModel *)model
{
    NSLog(@"custom order refresh");
}

-(void)cancelOrder
{
    NSLog(@"cancel order");
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //do cancel actioin
        [MBProgressHUD showProgressMessage:@"正在取消"];
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
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
