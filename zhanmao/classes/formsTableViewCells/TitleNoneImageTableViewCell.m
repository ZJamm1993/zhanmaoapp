//
//  TitleNoneImageTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleNoneImageTableViewCell.h"

@implementation TitleNoneImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    [self.image sd_setImageWithURL:[model.thumb urlWithMainUrl]];
}

@end
