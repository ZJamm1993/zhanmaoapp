//
//  PayOrderTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/5.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "PayOrderTableViewController.h"
#import "PayOrderCountDownHeaderView.h"
#import "MyPageCellModel.h"
#import "PayOrderTableViewCell.h"
#import "ZZPayTool.h"

@interface PayOrderTableViewController ()
{
    PayOrderCountDownHeaderView* headerView;
    PayMethodType selectedType;
}
@end

@implementation PayOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"订单付款";
    
    headerView=[[[UINib nibWithNibName:@"PayOrderCountDownHeaderView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    if ([headerView isKindOfClass:[PayOrderCountDownHeaderView class]]) {
        headerView.frame=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 44);
        headerView.backgroundColor=[UIColor whiteColor];
        
        headerView.totalTime=self.orderModel.expiration;
        headerView.moneyLabel.text=[NSString stringWithFloat:self.orderModel.amount headUnit:@"¥" tailUnit:nil];
        
        UIView* headerBg=[[UIView alloc]initWithFrame:headerView.bounds];
        [headerBg addSubview:headerView];
        self.tableView.tableHeaderView=headerBg;
    }
    
    [self.bottomButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.bottomButton addTarget:self action:@selector(payOrder) forControlEvents:UIControlEventTouchUpInside];
    
    MyPageCellModel* m_alipay=[[MyPageCellModel alloc]init];
    m_alipay.selected=NO;
    m_alipay.image=@"alipay";
    m_alipay.title=@"支付宝支付";
    m_alipay.type=PayMethodTypeAlipay;
    
    [self.dataSource addObject:m_alipay];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"选择支付方式";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"PayOrderTableViewCell" forIndexPath:indexPath];
    MyPageCellModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    cell.button.selected=mo.selected;
    cell.image.image=[UIImage imageNamed:mo.image];
    cell.title.text=mo.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    for (MyPageCellModel* me in self.dataSource) {
        me.selected=NO;
    }
    MyPageCellModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    mo.selected=YES;
    selectedType=mo.type;
    [self.tableView reloadData];
}

-(void)payOrder
{
    if (selectedType==PayMethodTypeAlipay)
    {
        NSLog(@"alipay");
    }
    else if (selectedType==PayMethodTypeWechatPay)
    {
        NSLog(@"wechatpay");
    }
    else if (selectedType==PayMethodTypeUnionpay)
    {
        NSLog(@"unionpay");
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请选择支付方式"];
        return;
    }
    [self payWithType:selectedType];
}

-(void)payWithType:(PayMethodType)type
{
    [RentHttpTool getPayOrderStringWithToken:[UserModel token] payType:[NSString stringWithFormat:@"%d",(int)type] orderId:self.orderModel.idd success:^(NSDictionary *dictionary) {
        NSLog(@"%@",dictionary);
        NSString* msg=[dictionary valueForKey:@"message"];
        BOOL code=dictionary.code==0;
        NSDictionary* data=[dictionary valueForKey:@"data"];
        if ([data respondsToSelector:@selector(allKeys)]) {
            if (type==PayMethodTypeAlipay) {
                NSString* alipayString=[data valueForKey:@"alipay"];
                [ZZPayTool payWithAlipayString:alipayString];
            }
        }
        if (!code) {
            [MBProgressHUD showErrorMessage:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
