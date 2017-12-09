//
//  TransportOrderDetailTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TransportOrderDetailTableViewController.h"
#import "OrderDetailStatusComplexStyleCell.h"

@interface TransportOrderDetailTableViewController ()

@property (weak, nonatomic) IBOutlet OrderDetailStatusComplexStyleCell *headerStatusCell;

@property (weak, nonatomic) IBOutlet UILabel *expressName;
@property (weak, nonatomic) IBOutlet UILabel *senderAddress;
@property (weak, nonatomic) IBOutlet UILabel *senderName;
@property (weak, nonatomic) IBOutlet UILabel *receiverAddress;
@property (weak, nonatomic) IBOutlet UILabel *receiverName;

@property (weak, nonatomic) IBOutlet UILabel *objectType;
@property (weak, nonatomic) IBOutlet UILabel *objectWeight;
@property (weak, nonatomic) IBOutlet UILabel *objectVolume;

@property (weak, nonatomic) IBOutlet UILabel *fee;

@property (weak, nonatomic) IBOutlet UILabel *payMethod;

@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *sendTime;

@end

@implementation TransportOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadModel];
    // Do any additional setup after loading the view.
    
    [OrderTypeDataSource getMyTransportOrderDetailById:self.transportModel.idd token:[UserModel token] success:^(TransportOrderModel *model) {
        if (model.idd.length>0) {
            self.transportModel=model;
            [self reloadModel];
            [self.tableView reloadData];
        }
    }];
}

-(void)reloadModel
{
    TransportOrderModel* mo=self.transportModel;
    
    self.expressName.text=mo.logistics_type;
    self.senderAddress.text=mo.sender_addr;
    self.senderName.text=mo.sender;
    self.receiverAddress.text=mo.collect_addr;
    self.receiverName.text=mo.collect;
    
    self.objectType.text=mo.item_type;
    self.objectWeight.text=[NSString stringWithFormat:@"%@%@",mo.professor,@"kg"];
    self.objectVolume.text=[NSString stringWithFormat:@"%@%@",mo.volume,@"m³"];
    
    self.fee.text=[NSString stringWithFloat:mo.evaluate.floatValue headUnit:@"¥" tailUnit:nil];
    
    self.payMethod.text=mo.pay_type;
    
    self.orderId.text=mo.order_num;
    self.createTime.text=mo.post_modified;
    self.sendTime.text=mo.send_date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

@end
