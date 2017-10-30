//
//  MyInvoiceTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyInvoiceTableViewCell.h"

@implementation MyInvoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    
    self.cardBg.layer.cornerRadius=8;
    self.checkButton.layer.cornerRadius=2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkButtonClicked:(id)sender {
    
}

@end
