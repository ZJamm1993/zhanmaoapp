//
//  ExhibitionLargeCardTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionLargeCardTableViewCell.h"

@implementation ExhibitionLargeCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.cornerRadius=4;
    self.bgView.layer.borderColor=gray_8.CGColor;
    self.bgView.layer.borderWidth=0.5;
    self.bgView.clipsToBounds=YES;
    self.bgView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCornerRadius
{
//    NSLog(@"%@",NSStringFromCGRect(self.bgView.bounds));
//    
//    CGRect bous=self.bgView.bounds;
//    bous.size.width=[[UIScreen mainScreen]bounds].size.width-16;
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = bous;
//    
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.frame = bous;
//    borderLayer.lineWidth = 1.f;
//    borderLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    borderLayer.fillColor = [UIColor clearColor].CGColor;
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bous cornerRadius:4];
//    maskLayer.path = bezierPath.CGPath;
//    borderLayer.path = bezierPath.CGPath;
//    
//    [self.bgView.layer insertSublayer:borderLayer atIndex:0];
//    [self.bgView.layer setMask:maskLayer];
    
}

-(void)layoutSubviews
{
//    [super layoutSubviews];
//    [self setCornerRadius];
}

@end
