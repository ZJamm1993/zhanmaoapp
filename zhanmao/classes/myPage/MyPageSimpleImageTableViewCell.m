//
//  MyPageSimpleImageTableViewCell.m
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageSimpleImageTableViewCell.h"

@implementation MyPageSimpleImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightArrow"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
