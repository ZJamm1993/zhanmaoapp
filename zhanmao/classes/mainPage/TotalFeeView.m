//
//  TotalFeeView.m
//  zhanmao
//
//  Created by bangju on 2017/11/14.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TotalFeeView.h"

@implementation TotalFeeView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.submitButton.layer.cornerRadius=4;
    self.submitButton.backgroundColor=_mainColor;
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.grayButton.layer.cornerRadius=4;
    self.grayButton.backgroundColor=[UIColor whiteColor];
    self.grayButton.layer.borderColor=gray_6.CGColor;
    self.grayButton.layer.borderWidth=0.5;
    [self.grayButton setTitleColor:gray_4 forState:UIControlStateNormal];
    
    self.grayButton.hidden=!self.showingGrayButton;;
}

-(void)setShowingGrayButton:(BOOL)showingGrayButton
{
    _showingGrayButton=showingGrayButton;
    self.submitButton.hidden=showingGrayButton;
    self.grayButton.hidden=!showingGrayButton;
}

@end
