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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(RentOrderModel *)model
{
    _model=model;
    
    self.title.text=model.title;
    
    self.stateTitle.text=[RentOrderModel cellStateForType:model.type];
    
    RentOrderType type=model.type;
    self.blueButton.hidden=(type==RentOrderTypeFinished);
    self.grayButton.hidden=!self.blueButton.hidden;
    
    NSString* buttonTitle=@"";
    if (type==RentOrderTypeFinished) {
        buttonTitle=@"关闭交易";
    }
    else if (type==RentOrderTypeNotPaid) {
        buttonTitle=@"立即付款";
    }
    else if (type==RentOrderTypeNotSigned) {
        buttonTitle=@"确认收货";
    }
    else if (type==RentOrderTypeNotReturned) {
        buttonTitle=@"确认归还";
    }
    [self.blueButton setTitle:buttonTitle forState:UIControlStateNormal];
    [self.grayButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
