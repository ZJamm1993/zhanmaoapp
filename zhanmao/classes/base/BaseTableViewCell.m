//
//  BaseTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIView*)bottomSeperateLine
{
    if(_bottomSeperateLine==nil)
    {
        _bottomSeperateLine=[[UIView alloc]initWithFrame:CGRectZero];
        _bottomSeperateLine.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_bottomSeperateLine];
    }
    return _bottomSeperateLine;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat he=0.5;
    self.bottomSeperateLine.frame=CGRectMake(0, self.contentView.bounds.size.height-he, self.contentView.bounds.size.width, he);
}

@end
