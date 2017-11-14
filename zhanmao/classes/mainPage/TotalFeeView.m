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
}

@end
