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
#import "PayOrderTableViewController.h"
#import "TotalFeeView.h"

@interface CleanOrderDetailTableViewController ()
{
    TotalFeeView* _totalFeeView;
    
    BOOL shouldPay;
}
@end

@implementation CleanOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"保洁订单详情";
    
    [self.bottomButton removeFromSuperview];
    _totalFeeView=[[[UINib nibWithNibName:@"TotalFeeView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    CGRect fr=self.bottomFrame;
    fr.size.height=64;
    _totalFeeView.frame=fr;
    _totalFeeView.title.text=@"总计：";
    [_totalFeeView.submitButton addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
    [self setBottomSubView:_totalFeeView];
    
    [self refresh];
    // Do any additional setup after loading the view.
}

#pragma mark reloads data

-(void)countingDown
{
    if (shouldPay) {
        [self.tableView reloadData];
    }
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
    shouldPay=self.cleanModel.pay_status==PayStatusNotYet&&self.cleanModel.order_status==CleanOrderStatusNotClean;
    
    if (shouldPay) {
        UIBarButtonItem* cancelItem=[[UIBarButtonItem alloc]initWithTitle:@"取消订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
        self.navigationItem.rightBarButtonItem=cancelItem;
        _totalFeeView.title.text=@"需付款：";
    }
    else
    {
        self.navigationItem.rightBarButtonItem=nil;
        _totalFeeView.title.text=@"总计：";
    }
    
    NSString* buttonString=[RentOrderModel cellButtonTitleForType:self.cleanModel.order_status];
    if (shouldPay) {
        buttonString=@"立即付款";
        [self setBottomBarHidden:NO];
    }
    else
    {
        [self setBottomBarHidden:YES];
    }
    
    [_totalFeeView.submitButton setTitle:buttonString forState:UIControlStateNormal];
    [_totalFeeView.grayButton setTitle:buttonString forState:UIControlStateNormal];
    
//    _totalFeeView.submitButton.hidden=!(self.cleanModel.order_status<=CleanOrderStatusNotClean);
//    _totalFeeView.grayButton.hidden=!_totalFeeView.submitButton.hidden;
    
    _totalFeeView.feeLabe.text=[NSString stringWithFloat:self.cleanModel.amount headUnit:@"¥" tailUnit:nil];
    
    // do get method
    [self.tableView reloadData];
}

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel
{
    if ([self.cleanModel isKindOfClass:[orderModel class]]) {
        if ([self.cleanModel.idd isEqualToString:orderModel.idd]) {
            [self refresh];
        }
    }
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
            
            if (shouldPay) {
                
                statusCell.title.text=@"等待付款";
                
                NSString* detailString=@"%@后自动取消订单";
                CGFloat expir=self.cleanModel.expiration;
                CGFloat current=[[NSDate date]timeIntervalSince1970];
                CGFloat seconds=expir-current;
                if (seconds<0) {
                    seconds=0;
                }
                NSInteger mins=((long)seconds)/60;
                NSInteger secs=((long)seconds)%60;
                NSString* countDownTime=[NSString stringWithFormat:@"%ld分%ld秒",(long)mins,(long)secs];
                
                if ([detailString containsString:@"%@"]) {
                    detailString=[NSString stringWithFormat:detailString,countDownTime];
                }
                statusCell.detail.text=detailString;
            }
            
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
            NSString* detailString=@"";
            detailString=[NSString stringWithFormat:@"%@%@%@",detailString,@"套餐面积：",[NSString stringWithFloat:self.cleanModel.professor headUnit:nil tailUnit:UnitStringSquareMeter]];
            detailString=[NSString stringWithFormat:@"%@\n%@%@",detailString,@"额外套餐面积：",[NSString stringWithFloat:self.cleanModel.other headUnit:nil tailUnit:UnitStringSquareMeter]];
            if (self.cleanModel.number.length>0) {
                detailString=[NSString stringWithFormat:@"%@\n%@%@",detailString,@"订单编号：",self.cleanModel.number];
            }
            if (self.cleanModel.post_modified.length>0) {
                detailString=[NSString stringWithFormat:@"%@\n%@%@",detailString,@"下单时间：",self.cleanModel.post_modified];
            }
            
            if (self.cleanModel.date.length>0) {
                detailString=[NSString stringWithFormat:@"%@\n%@%@",detailString,@"服务时间：",self.cleanModel.date];
            }
            longDetailCell.label.text=detailString;
            return longDetailCell;
        }
        else
        {
            CleanOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CleanOrderTableViewCell" forIndexPath:indexPath];
            cell.title.text=self.cleanModel.addr;
            cell.baseFee.text=[NSString stringWithFloat:self.cleanModel.cost headUnit:@"¥" tailUnit:nil];
            cell.otherFee.text=[NSString stringWithFloat:self.cleanModel.other headUnit:@"¥" tailUnit:nil];
            cell.totalFee.text=[NSString stringWithFloat:self.cleanModel.amount headUnit:@"¥" tailUnit:nil];
            return cell;
        }
    }
    return [[UITableViewCell alloc]init];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([super respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [super scrollViewDidScroll:scrollView];
    }
    CGRect fr=_totalFeeView.frame;
    fr.size.height=64;
    _totalFeeView.frame=fr;
}

#pragma mark actions

-(void)doAction
{
    if(self.cleanModel.pay_status==PayStatusNotYet)
    {
        PayOrderTableViewController* pay=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"PayOrderTableViewController"];
        pay.orderModel=self.cleanModel.pay;
        pay.orderType=PayOrderTypeClean;
        [self.navigationController pushViewController:pay animated:YES];
    }
}

-(void)cancelOrder
{
    NSLog(@"cancel order");
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //do cancel actioin
        //        #warning not finish clean order detail cancel action
        [MBProgressHUD showProgressMessage:@"正在取消"];
        [OrderTypeDataSource postMyCleanOrderCancelById:self.cleanModel.idd token:[UserModel token] success:^(BOOL result, NSString *msg) {
            if (result) {
                [MBProgressHUD showSuccessMessage:msg];
                [self refresh];
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
