//
//  RentActionEditView.m
//  zhanmao
//
//  Created by bangju on 2017/11/7.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentActionEditView.h"

@implementation RentActionEditView

+(instancetype)defaultView
{
    RentActionEditView* vi=[[[UINib nibWithNibName:@"RentActionEditView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    return vi;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cartBg.backgroundColor=[UIColor whiteColor];
    self.cartBg.layer.cornerRadius=8;
    
    self.darkBg.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
    
    self.addToCartButton.layer.cornerRadius=4;
    self.addToCartButton.layer.borderColor=_mainColor.CGColor;
    self.addToCartButton.layer.borderWidth=0.5;
    [self.addToCartButton setTitleColor:_mainColor forState:UIControlStateNormal];
    
    self.rentNowButton.layer.cornerRadius=4;
    [self.rentNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rentNowButton setBackgroundColor:_mainColor];
    
//    self.xButton.layer.cornerRadius=self.xButton.frame.size.width/2;
}

-(void)show
{
    [self showWithBottomInset:0];
}

-(void)showWithBottomInset:(CGFloat)bottomInset
{
    [self removeFromSuperview];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    
    CGRect windRect=[[UIScreen mainScreen]bounds];
    CGRect orgRe=windRect;
    orgRe.origin.y=orgRe.size.height;
    
    windRect.origin.y=-bottomInset;
    
    self.frame=orgRe;
    self.darkBg.alpha=0;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame=windRect;
        self.darkBg.alpha=1;
    } completion:nil];
}

-(void)setCartModel:(RentCartModel *)cartModel
{
    _cartModel=cartModel;
    
    self.titleLabel.text=cartModel.product.post_title;
    [self.image sd_setImageWithURL:[cartModel.product.thumb urlWithMainUrl]];
    self.rentLabel.text=[NSString stringWithFloat:cartModel.product.rent headUnit:@"¥" tailUnit:RentGoodPriceUnit];
    self.depositLabel.text=[NSString stringWithFloat:cartModel.product.deposit headUnit:@"¥" tailUnit:nil];
    self.discountRentLabel.text=[NSString stringWithFloat:cartModel.product.rent headUnit:@"¥" tailUnit:nil];
    self.originalRentLabel.text=[NSString stringWithFloat:cartModel.product.rent_o headUnit:@"¥" tailUnit:nil];
}

- (IBAction)countValueChanged:(ZZStepper*)sender {
    self.cartModel.count=sender.value;
    self.cartModel=self.cartModel;
}

- (IBAction)daysValueChanged:(ZZStepper*)sender {
//    self.cartModel.days=sender.value;
//    self.cartModel=self.cartModel;
}

-(void)hide
{
    CGRect windRect=[[UIScreen mainScreen]bounds];
    CGRect orgRe=windRect;
    orgRe.origin.y=orgRe.size.height;
    
//    self.frame=orgRe;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame=orgRe;
        self.alpha=0;
    } completion:^(BOOL isFinish){
        
        [self removeFromSuperview];
    }];
}
- (IBAction)xPress:(id)sender {
    [self hide];
}

- (IBAction)addToCartPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(rentActionEditViewAddToRentCart:)]) {
        [self.delegate rentActionEditViewAddToRentCart:self.cartModel];
    }
    [self hide];
}

- (IBAction)rentNowPress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(rentActionEditViewRentNow:)]) {
        [self.delegate rentActionEditViewRentNow:self.cartModel];
    }
    [self hide];
}

@end
