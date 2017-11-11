//
//  TitleDescriptionTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleDescriptionTableViewCell.h"

@implementation TitleDescriptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor=[UIColor clearColor];
    
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
    self.title.text=model.hint;
}

@end
