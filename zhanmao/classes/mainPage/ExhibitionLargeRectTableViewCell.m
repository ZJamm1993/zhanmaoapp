//
//  ExhibitionLargeRectTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionLargeRectTableViewCell.h"

@implementation ExhibitionLargeRectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailTitle.textColor=_mainColor;
    
    self.detailTitleBg.layer.borderColor=_mainColor.CGColor;
    self.detailTitleBg.layer.borderWidth=1/[[UIScreen mainScreen]scale];
    self.detailTitleBg.layer.cornerRadius=self.detailTitleBg.frame.size.height/2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
