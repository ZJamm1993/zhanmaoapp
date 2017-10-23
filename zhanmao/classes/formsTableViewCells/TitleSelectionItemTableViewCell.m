//
//  TitleSelectionItemTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleSelectionItemTableViewCell.h"

@implementation TitleSelectionItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRadioSelected:(BOOL)radioSelected
{
    _radioSelected=radioSelected;
    self.selectedImageView.hidden=!radioSelected;
    
}

@end
