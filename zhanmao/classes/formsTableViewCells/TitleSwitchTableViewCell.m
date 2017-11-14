//
//  TitleSwitchTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/13.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleSwitchTableViewCell.h"

@implementation TitleSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tap.onTintColor=_mainColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.tap.on=!self.tap.on;
        [self valueChanged];
    }
    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    self.title.text=model.name;
    self.tap.on=model.value.boolValue;
    
    if (model.value.length==0) {
        model.value=@"0";
    }
}

- (IBAction)switchValueChanged:(id)sender {
    [self valueChanged];
}

-(void)valueChanged
{
    self.model.value=[NSString stringWithFormat:@"%i",self.tap.on];
    [self reloadModel];
}

@end
