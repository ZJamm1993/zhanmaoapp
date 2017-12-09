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
        NSInteger row=self.rentModel.goods.count+2;
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
        else if(row==1)
        {
            OrderDetailAddressCell* addressCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailAddressCell" forIndexPath:indexPath];
            
            return addressCell;
        }
        else if(row==2)
        {
            OrderDetailSimpleLeftLabelCell* emergCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailSimpleLeftLabelCell" forIndexPath:indexPath];
            emergCell.label.text=@"紧急联系人 110 120 119";
            return emergCell;
        }
    }
    else if(sec==1)
    {
        NSInteger totalRowOfSection=[tableView numberOfRowsInSection:sec];
        
        BOOL isPaid=self.rentModel.status!=RentOrderStatusNotPaid;
        
        if (row==totalRowOfSection-1) {
            OrderDetailSimpleLeftLabelCell* longDetailCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailSimpleLeftLabelCell" forIndexPath:indexPath];
            longDetailCell.label.text=@"订单编号：139819823712837\n下单时间：2011-12-32 12:12:23\n上单时间：2011-12-32 12:12:23";
            return longDetailCell;
        }
        else if ((isPaid&&row==totalRowOfSection-2)) {
            OrderDetailSimpleLeftLabelCell* payMethodCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailSimpleLeftLabelCell" forIndexPath:indexPath];
            payMethodCell.label.text=@"支付方式：paypal";
            return payMethodCell;
        }
        else if((isPaid&&row==totalRowOfSection-3)||(!isPaid&&row==totalRowOfSection-2))
        {
            RentOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentOrderTableViewCellPriceDetail" forIndexPath:indexPath];
            cell.orderModel=self.rentModel;
            return cell;
        }
        else
        {
            RentOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentOrderTableViewCellProductDetail" forIndexPath:indexPath];
            if(row<self.rentModel.goods.count)
            {
                RentCartModel* goo=[self.rentModel.goods objectAtIndex:row];
                cell.cartModel=goo;
            }
            return cell;
        }
    }
    return [[UITableViewCell alloc]init];
}

@end
