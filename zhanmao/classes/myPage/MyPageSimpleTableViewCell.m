//
//  MyPageSimpleTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageSimpleTableViewCell.h"

@implementation MyPageSimpleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorInset=UIEdgeInsetsMake(0, 16, 0, 0);
    
    self.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightArrow"]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.accessoryView) {
        CGRect fr=self.detailTextLabel.frame;
        fr.origin.x=fr.origin.x-10;
        self.detailTextLabel.frame=fr;
    }
}

@end
