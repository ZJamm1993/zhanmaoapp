//
//  TitleSelectionHeaderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleSingleSelectionTableViewCell.h"
#import "PickerShadowContainer.h"

@implementation TitleSingleSelectionTableViewCell
{
    UIDatePicker* datePicker;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        if (self.model.type==BaseFormTypeTimePicker) {
            if (datePicker==nil) {
                datePicker=[[UIDatePicker alloc]init];
                datePicker.minimumDate=[NSDate date];
                datePicker.backgroundColor=[UIColor whiteColor];
                datePicker.datePickerMode=UIDatePickerModeDate;
                datePicker.minuteInterval=30;
            }
            [PickerShadowContainer showPickerContainerWithView:datePicker completion:^{
                [self valueChanged];
            }];
        }
    }
    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    self.title.text=model.name;
    self.detail.text=model.value;
}

-(void)valueChanged
{
    if (self.model.type==BaseFormTypeTimePicker)
    {
        NSDate* date=datePicker.date;
        NSDateFormatter* forma=[[NSDateFormatter alloc]init];
        forma.dateFormat=@"yyyy-MM-dd HH:mm:ss";
        NSString* dateString=[forma stringFromDate:date];
        self.detail.text=dateString;
        self.model.value=dateString;
    }
}

@end
