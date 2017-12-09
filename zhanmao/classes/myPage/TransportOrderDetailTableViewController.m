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
    
    self.senderName.text=@"sadj09fi092ir09r2i3ifj 09ji3j029ff10dk13k3k10238102";
    // Do any additional setup after loading the view.
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
