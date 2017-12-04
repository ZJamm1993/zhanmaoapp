//
//  TitleTextViewTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleTextViewTableViewCell.h"

@implementation TitleTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    if(!self.textView.isFirstResponder)
        self.textView.text=model.value;
    self.placeHolder.text=model.hint;
    self.title.text=model.name;
    
    self.placeHolder.hidden=self.textView.text.length>0;
}

-(void)valueChanged
{
    self.model.value=self.textView.text;
    [self reloadModel];
}

@end
