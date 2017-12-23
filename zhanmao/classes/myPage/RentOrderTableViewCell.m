//
//  RentOrderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderTableViewCell.h"

@implementation RentOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
    
    self.blueButton.layer.cornerRadius=2;
    self.blueButton.layer.masksToBounds=YES;
//    self.blueButton setTitle:@ forState:(UIControlState)
    [self.blueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.blueButton setBackgroundColor:_mainColor];
    
    self.grayButton.layer.cornerRadius=2;
    self.grayButton.layer.masksToBounds=YES;
    self.grayButton.layer.borderColor=gray_4.CGColor;
    self.grayButton.layer.borderWidth=1/[[UIScreen mainScreen]scale];
    [self.grayButton setTitleColor:gray_4 forState:UIControlStateNormal];
    [self.grayButton setBackgroundColor:[UIColor clearColor]];
    
    [self.blueButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.grayButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    self.grayButton.userInteractionEnabled=NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOrderModel:(RentOrderModel *)orderModel
{
    _orderModel=orderModel;
    
//    self.title.text=orderModel.title;
    self.createTime.text=[orderModel.createtime dateString];
    self.stateTitle.text=[RentOrderModel cellStateForType:orderModel.order_status];
    
    RentOrderStatus type=orderModel.order_status;
    
    BOOL shouPay=type<=RentOrderStatusNotReceived||orderModel.pay_status==PayStatusNotYet;
    
    self.blueButton.hidden=!(shouPay);
    self.grayButton.hidden=!self.blueButton.hidden;
    
    NSString* buttonTitle=[RentOrderModel cellButtonTitleForType:orderModel.order_status];
    
    if (orderModel.pay_status==PayStatusNotYet&&shouPay) {
        buttonTitle=@"立即付款";
        self.stateTitle.text=@"待付款";
    }
    
//    NSLog(@"pay:%ld status%ld",orderModel.pay_status,type);
    
    [self.blueButton setTitle:buttonTitle forState:UIControlStateNormal];
    [self.grayButton setTitle:buttonTitle forState:UIControlStateNormal];
    
    self.days.text=[NSString stringWithFormat:@"%ld周期(%ld天)",(long)orderModel.leaseperiod,(long)orderModel.leaseperiod*4];
    
    self.amount.text=[NSString stringWithFloat:orderModel.pay.amount headUnit:@"¥" tailUnit:nil];
}

-(void)setCartModel:(RentCartModel *)cartModel
{
    _cartModel=cartModel;
    
    self.title.text=cartModel.product.post_title;
    [self.image sd_setImageWithURL:[cartModel.product.thumb urlWithMainUrl]];
    self.rent.text=[NSString stringWithFloat:cartModel.product.rent headUnit:@"¥" tailUnit:@"/一周期(4天)"];
    self.count.text=[NSString stringWithFormat:@"%ld",(long)cartModel.count];
    self.deposit.text=[NSString stringWithFloat:cartModel.product.deposit headUnit:@"¥" tailUnit:nil];
}

-(void)buttonClick
{
    if ([self.delegate respondsToSelector:@selector(rentOrderTableViewCellActionButtonClick:)]) {
        [self.delegate rentOrderTableViewCellActionButtonClick:self];
    }
}

@end
