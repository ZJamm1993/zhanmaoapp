//
//  ProductSmallTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/18.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MessageSmallTableViewCell.h"

@implementation MessageSmallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _footerView.backgroundColor=gray_9;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShowReadCount:(BOOL)showReadCount
{
    _showReadCount=showReadCount;
    self.readCountView.hidden=!showReadCount;
}

-(void)setShowImage:(BOOL)showImage
{
    _showImage=showImage;
    
    // 82
    // 16
    
    if (showImage) {
        self.imageWidthConstraint.constant=82;
        self.titleLeadingContraint.constant=16;
    }
    else
    {
        self.imageWidthConstraint.constant=0;
        self.titleLeadingContraint.constant=0;
    }
}

@end
