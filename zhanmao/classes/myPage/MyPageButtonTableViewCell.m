//
//  MyPageButtonTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageButtonTableViewCell.h"

@implementation MyPageButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    
//    self.button.userInteractionEnabled=NO;
    [self.button setBackgroundImage:[UIImage imageWithColor:_mainColor size:self.button.frame.size] forState:UIControlStateNormal];
    self.button.layer.cornerRadius=6;
    self.button.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
