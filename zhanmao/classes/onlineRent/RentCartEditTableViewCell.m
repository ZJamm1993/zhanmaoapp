//
//  RentCartEditTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentCartEditTableViewCell.h"

@implementation RentCartEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.countStepper.min=1;
    self.dayStepper.min=1;
    
    self.separatorInset=UIEdgeInsetsZero;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEditing:(BOOL)editing
{
    self.editingBg.hidden=!editing;
    self.normalBg.hidden=editing;
    self.title.hidden=editing;
}

-(void)setCartModel:(RentCartModel *)cartModel
{
    _cartModel=cartModel;
    
//    if (cartModel.selected) {
//        //[self.selectButton setTitle:@"$" forState:UIControlStateNormal];
//        self.selectButton.backgroundColor=[UIColor blueColor];
//    }
//    else
//    {
//        //[self.selectButton setTitle:@"" forState:UIControlStateNormal];
//        self.selectButton.backgroundColor=[UIColor lightGrayColor];
//    }
    self.selectButton.selected=cartModel.selected;
    
    self.title.text=cartModel.product.post_title;
    [self.image sd_setImageWithURL:[cartModel.product.thumb urlWithMainUrl]];
    self.rent.text=[NSString stringWithFloat:cartModel.product.rent headUnit:@"¥" tailUnit:@"/"];
    self.deposit.text=[NSString stringWithFloat:cartModel.product.deposit headUnit:@"¥" tailUnit:nil];
    
    
    self.countStepper.value=cartModel.count;
//    self.dayStepper.value=cartModel.days;
    
    self.count.text=[NSString stringWithFormat:@"%ld",(long)cartModel.count];
//    self.days.text=[NSString stringWithFormat:@"%ld",(long)cartModel.days];
}

- (IBAction)selectedButtonClick:(id)sender {
    self.cartModel.selected=!self.cartModel.selected;
    self.cartModel=self.cartModel;
    [self modelChanged];
}

- (IBAction)deleteButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(rentCartEditTableViewCell:deleteCartModel:)]) {
        [self.delegate rentCartEditTableViewCell:self deleteCartModel:self.cartModel];
    }
}

- (IBAction)countStepperValueChanged:(ZZStepper*)sender {
    self.cartModel.count=sender.value;
    self.cartModel=self.cartModel;
    [self modelChanged];
}

- (IBAction)daysStepperValueChanged:(ZZStepper*)sender {
//    self.cartModel.days=sender.value;
//    self.cartModel=self.cartModel;
//    [self modelChanged];
}

-(void)modelChanged
{
    if ([self.delegate respondsToSelector:@selector(rentCartEditTableViewCell:didChangeModel:)]) {
        [self.delegate rentCartEditTableViewCell:self didChangeModel:self.cartModel];
    }
}

@end
