//
//  TitleSelectionHeaderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleSingleSelectionTableViewCell.h"
#import "PickerShadowContainer.h"
#import "CitySelectionPicker.h"

@interface TitleSingleSelectionTableViewCell()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation TitleSingleSelectionTableViewCell
{
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        if (self.model.type==BaseFormTypeDatePicker||self.model.type==BaseFormTypeDateScopePicker||self.model.type==BaseFormTypeDateTimePicker||self.model.type==BaseFormTypeDateTime48Picker) {
            
            UIDatePicker* datePicker=[[UIDatePicker alloc]init];
            datePicker.minimumDate=[NSDate date];
            datePicker.backgroundColor=[UIColor whiteColor];
            
            NSString* format=@"yyyy-MM-dd HH:mm";
            
            if (self.model.type==BaseFormTypeDateTimePicker||self.model.type==BaseFormTypeDateTime48Picker) {
                
                datePicker.datePickerMode=UIDatePickerModeDateAndTime;
                if (self.model.type==BaseFormTypeDateTime48Picker) {
                    datePicker.minimumDate=[NSDate dateWithTimeIntervalSinceNow:172800];
                }
            }
            else if(self.model.type==BaseFormTypeDatePicker||self.model.type==BaseFormTypeDateScopePicker)
            {
                datePicker.datePickerMode=UIDatePickerModeDate;
                format=@"yyyy-MM-dd";
            }
            datePicker.minuteInterval=30;
            
            NSDateFormatter* formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:format];
            
            NSString* tit=self.model.hint;
            if(self.model.type==BaseFormTypeDateScopePicker)
            {
                tit=@"请选择开始时间";
            }
            
            [PickerShadowContainer showPickerContainerWithView:datePicker title:tit completion:^{
                NSString* value1=[formatter stringFromDate:datePicker.date];
                
                if (self.model.type==BaseFormTypeDateScopePicker) {
                    datePicker.minimumDate=datePicker.date;
                    [PickerShadowContainer showPickerContainerWithView:datePicker title:@"请选择结束时间" completion:^{
                        NSString* value2=[formatter stringFromDate:datePicker.date];
                        self.model.value=[NSString stringWithFormat:@"%@至%@",value1,value2];
                        [self valueChanged];
                    }];
                    return;
                }
                
                self.model.value=value1;
                [self valueChanged];
            }];
        }
        else if(self.model.type==BaseFormTypeSingleChoice)
        {
            UIPickerView* singlePicker=[[UIPickerView alloc]init];
            singlePicker.dataSource=self;
            singlePicker.delegate=self;
            singlePicker.backgroundColor=[UIColor whiteColor];
            [singlePicker reloadAllComponents];
            [PickerShadowContainer showPickerContainerWithView:singlePicker title:self.model.hint completion:^{
                NSString* str=[self pickerView:singlePicker titleForRow:[singlePicker selectedRowInComponent:0] forComponent:0];
                self.model.value=str;
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
        else if(self.model.type==BaseFormTypeProviceCityDistrict)
        {
            CitySelectionPicker* cit=[CitySelectionPicker defaultCityPickerWithSections:3];
            [PickerShadowContainer showPickerContainerWithView:cit title:self.model.hint completion:^{
                NSArray* citys=cit.selectedCity;
                NSInteger count=citys.count;
                if (self.model.combination_arr.count<count) {
                    count=self.model.combination_arr.count;
                }
                NSString* value=@"";
                for (NSInteger i=0; i<count; i++) {
                    BaseFormModel* subModel=[self.model.combination_arr objectAtIndex:i];
                    subModel.value=[citys objectAtIndex:i];
                    value=[NSString stringWithFormat:@"%@%@",value,subModel.value];
                }
                self.model.value=value;
                
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
    self.placeHolder.text=model.hint;
    self.unit.text=model.unit;
    self.placeHolder.hidden=self.detail.text.length>0;
//    [self valueChanged];
    
//    NSInteger count=self.model.combination_arr.count;
//    if (count>0) {
//        NSString* combinaTitleValue=@"";
//        for (NSInteger i=0; i<count; i++) {
//            BaseFormModel* subModel=[self.model.combination_arr objectAtIndex:i];
//            if (subModel.value.length>0) {
//                combinaTitleValue=[NSString stringWithFormat:@"%@%@",combinaTitleValue,subModel.value];
//            }
//        }
//        if (combinaTitleValue.length>0) {
//            statements
//        }
//    }
    
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
    [self reloadModel];
}

@end
