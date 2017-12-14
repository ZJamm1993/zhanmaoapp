//
//  CleanOrderDetailTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CleanOrderDetailTableViewController.h"

#import "OrderDetailAddressCell.h"
#import "OrderDetailStatusSimpleStyleCell.h"
#import "OrderDetailSimpleLeftLabelCell.h"
#import "CleanOrderTableViewCell.h"

@interface CleanOrderDetailTableViewController ()

@end

@implementation CleanOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
    // Do any additional setup after loading the view.
}

-(void)refresh
{
    [OrderTypeDataSource getMyCleanOrderDetailById:self.cleanModel.idd token:[UserModel token] success:^(CleanOrderModel *model) {
        if (model.idd.length>0) {
            self.cleanModel=model;
            [self reloadWithOrder];
        }
    }];
}

-(void)reloadWithOrder
{
    if (self.cleanModel.pay_status==PayStatusNotYet) {
        UIBarButtonItem* cancelItem=[[UIBarButtonItem alloc]initWithTitle:@"取消订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
        self.navigationItem.rightBarButtonItem=cancelItem;
    }
    else
    {
        self.navigationItem.rightBarButtonItem=nil;
    }
    [self.tableView reloadData];
    // do get method
}

-(void)cancelOrder
{
    NSLog(@"cancel order");
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //do cancel actioin
        #warning not finish clean order detail cancel action
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
        return 2;
    }
    else if(section==1)
    {
        NSInteger row=2;
//        if (self.cleanModel.order_status!=RentOrderStatusNotPaid)
//        {
//            row=row+1; //showing pay method:
//        }
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
            
            statusCell.title.text=[CleanOrderModel detailHeaderTitleForType:self.cleanModel.order_status];
            statusCell.detail.text=[CleanOrderModel detailHeaderDescritionForType:self.cleanModel.order_status];
            return statusCell;
        }
        else if(row==1)
        {
            OrderDetailAddressCell* addressCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailAddressCell" forIndexPath:indexPath];
            addressCell.address.text=self.cleanModel.addr;
            addressCell.name.text=self.cleanModel.addressee;
            addressCell.phone.text=self.cleanModel.m_phone;
            return addressCell;
        }
    }
    else if(sec==1)
    {
        NSInteger totalRowOfSection=[tableView numberOfRowsInSection:sec];
        
//        BOOL isPaid=self.cleanModel.order_status!=RentOrderStatusNotPaid;
        
        if (row==totalRowOfSection-1) {
            OrderDetailSimpleLeftLabelCell* longDetailCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailSimpleLeftLabelCell" forIndexPath:indexPath];
            longDetailCell.label.text=@"?";
            return longDetailCell;
        }
//        else if ((isPaid&&row==totalRowOfSection-2)) {
//            OrderDetailSimpleLeftLabelCell* payMethodCell=[tableView dequeueReusableCellWithIdentifier:@"OrderDetailSimpleLeftLabelCell" forIndexPath:indexPath];
//            payMethodCell.label.text=@"支付方式：paypal";
//            return payMethodCell;
//        }
        else
        {
            CleanOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CleanOrderTableViewCell" forIndexPath:indexPath];
            cell.title.text=@"?";
            return cell;
        }
    }
    return [[UITableViewCell alloc]init];
    
#warning not finish clean order detail
}

@end
