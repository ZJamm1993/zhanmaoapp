//
//  CleanOrderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CleanOrderTableViewCell.h"

@implementation CleanOrderTableViewCell

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

@end
