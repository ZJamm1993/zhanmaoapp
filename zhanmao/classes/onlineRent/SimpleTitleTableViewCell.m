//
//  SimpleTitleTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "SimpleTitleTableViewCell.h"

@implementation SimpleTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.separatorInset=UIEdgeInsetsZero;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
//    self.selectedBackgroundView=[[UIView alloc]init];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.title.textColor=_mainColor;
        self.selectedTag.backgroundColor=_mainColor;
    }
    else
    {
        self.title.textColor=gray_2;
        self.selectedTag.backgroundColor=[UIColor clearColor];
    }
    // Configure the view for the selected state
}

-(UIEdgeInsets)separatorInset
{
    return UIEdgeInsetsZero;
}

@end
