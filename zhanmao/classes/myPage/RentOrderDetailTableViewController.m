//
//  RentOrderDetailTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/21.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderDetailTableViewController.h"
#import "RentOrderTableViewCell.h"
#import "OrderDetailAddressCell.h"
#import "OrderDetailStatusSimpleStyleCell.h"
#import "OrderDetailSimpleLeftLabelCell.h"

@interface RentOrderDetailTableViewController ()

@end

@implementation RentOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadWithOrder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadWithOrder
{
    if (self.rentModel.status!=RentOrderStatusNotPaid) {
        UIBarButtonItem* cancelItem=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
        self.navigationItem.rightBarButtonItem=cancelItem;
    }
    else
    {
        self.navigationItem.rightBarButtonItem=nil;
    }
}

-(void)cancelOrder
{
    NSLog(@"cancel order");
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //do cancel actioin
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    else if(section==1)
    {
        NSInteger row=3;
        if (self.rentModel.status!=RentOrderStatusNotPaid)
        {
            row=row+1; //showing pay method:
        }
        return row;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    
    if (sec==0) {
        if (row==0) {
            OrderDetailStatusSimpleStyleCell* statusCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailStatusSimpleStyleCell" forIndexPath:indexPath];
            statusCell.title.text=nil;
            statusCell.detail.text=nil;
            statusCell.title.text=[RentOrderModel cellStateForType:self.rentModel.status];
            statusCell.detail.text=@"?";
            return statusCell;
        }
    }
    return [[UITableViewCell alloc]init];
}

@end
