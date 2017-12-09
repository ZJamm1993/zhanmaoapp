//
//  CustomOrderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/8.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderTableViewCell.h"

@implementation CustomOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCanceled:(BOOL)canceled
{
    _canceled=canceled;
    self.cancelLabel.text=canceled?@"已取消":@"";
}

@end
