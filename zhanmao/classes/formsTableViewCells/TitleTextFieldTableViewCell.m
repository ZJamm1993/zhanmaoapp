//
//  TitleTextFieldTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleTextFieldTableViewCell.h"

@implementation TitleTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self.textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    if(!self.textField.isFirstResponder)
        self.textField.text=model.value;
    self.title.text=model.name;
    self.unit.text=model.unit;
    self.placeHolder.text=model.hint;
    
    self.placeHolder.hidden=self.textField.text.length>0;
//    self.textField.textAlignment=model.unit.length>0?NSTextAlignmentRight:NSTextAlignmentLeft;
}

-(void)valueChanged
{
//    NSLog(@"%@",self.model);
//    NSLog(@"%@",self.textField.text);
    self.model.value=self.textField.text;
    [self reloadModel];
}

@end
