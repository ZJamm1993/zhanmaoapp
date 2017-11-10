//
//  TitleSelectionHeaderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleSingleSelectionTableViewCell.h"
#import "PickerShadowContainer.h"

@interface TitleSingleSelectionTableViewCell()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation TitleSingleSelectionTableViewCell
{
    UIDatePicker* datePicker;
    UIPickerView* singlePicker;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    
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
        else if(self.model.type==BaseFormTypeSingleChoice)
        {
            if (singlePicker==nil) {
                singlePicker=[[UIPickerView alloc]init];
                singlePicker.dataSource=self;
                singlePicker.delegate=self;
                singlePicker.backgroundColor=[UIColor whiteColor];
            }
            [singlePicker reloadAllComponents];
            [PickerShadowContainer showPickerContainerWithView:singlePicker completion:^{
                [self valueChanged];
            }];
            
            if (self.model.value.length>0) {
                if ([self.model.option containsObject:self.model.value]) {
                    NSInteger inte=[self.model.option indexOfObject:self.model.value];
                    if (inte<[singlePicker numberOfRowsInComponent:0]) {
                        [singlePicker selectRow:inte inComponent:0 animated:NO];
                    }
                }
            }
        }
    }
    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    self.title.text=model.name;
    self.detail.text=model.value;
    self.placeHolder.text=model.hint;
    
    self.placeHolder.hidden=self.detail.text.length>0;
//    [self valueChanged];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.model.option.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.model.option objectAtIndex:row];
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
    else if(self.model.type==BaseFormTypeSingleChoice)
    {
        NSInteger inte=[singlePicker selectedRowInComponent:0];
        if (inte<self.model.option.count) {
            NSString* va=[self.model.option objectAtIndex:inte];
            self.detail.text=va;
            self.model.value=va;
        }
    }
    
    self.placeHolder.hidden=self.title.text.length>0;
}

@end
