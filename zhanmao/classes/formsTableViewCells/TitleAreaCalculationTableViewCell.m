//
//  TitleAreaCalculationTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleAreaCalculationTableViewCell.h"
#import "PickerShadowContainer.h"

@interface TitleAreaCalculationTableViewCell()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation TitleAreaCalculationTableViewCell
{
    NSArray* pickerStrings;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self performSelector:@selector(textFieldChanged:) withObject:textField afterDelay:0.1];
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.fields containsObject:textField]) {
        NSInteger which=[self.fields indexOfObject:textField];
        if (which<self.model.combination_arr.count) {
            BaseFormModel* sub=[self.model.combination_arr objectAtIndex:which];
            if (sub.option.count>0) {
                pickerStrings=[NSArray arrayWithArray:sub.option];
                UIPickerView* singlePicker=[[UIPickerView alloc]init];
                singlePicker.dataSource=self;
                singlePicker.delegate=self;
                singlePicker.backgroundColor=[UIColor whiteColor];
                [singlePicker reloadAllComponents];
                [PickerShadowContainer showPickerContainerWithView:singlePicker title:sub.hint completion:^{
                    NSString* str=[self pickerView:singlePicker titleForRow:[singlePicker selectedRowInComponent:0] forComponent:0];
                    sub.value=str;
                    textField.text=str;
                    [self textFieldChanged:textField];
                }];
                [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
                return NO;
            }
        }
    }
    return YES;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerStrings.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerStrings objectAtIndex:row];
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    NSInteger modelCount=model.combination_arr.count;
    for (NSInteger i=0;i<modelCount;i++) {
        BaseFormModel* m=[model.combination_arr objectAtIndex:i];
        if (self.titles.count>i) {
            UILabel* ti=[self.titles objectAtIndex:i];
            ti.text=m.name;
        }
        if (self.fields.count>i) {
            UITextField* fi=[self.fields objectAtIndex:i];
            fi.text=m.value;
            fi.placeholder=nil;//m.hint;
        }
        if (self.units.count>i) {
            UILabel* un=[self.units objectAtIndex:i];
            un.text=m.unit;
        }
    }
    BOOL showingBottom=modelCount>3;
    if (showingBottom) {
        [self calculate];
            }
    self.bottomResultView.hidden=!showingBottom;
    self.bottomResultViewHeight.constant=showingBottom?44:0;
}

-(void)textFieldChanged:(UITextField*)textField;
{
    if ([self.fields containsObject:textField]) {
        NSInteger ind=[self.fields indexOfObject:textField];
//        NSLog(@"%ld,%@",ind,textField);
        if (self.model.combination_arr.count>ind) {
            BaseFormModel* mo=[self.model.combination_arr objectAtIndex:ind];
            mo.value=textField.text;
            [self calculate];
            self.model.value=[[NSDate date]description];
            [self reloadModel];
        }
    }
}

-(void)calculate
{
    CGFloat totalArea=1;
    NSInteger mutaCount=2;
    if (self.model.type==BaseFormTypeCalculateSize) {
        mutaCount=3;
    }
    for (NSInteger i=0; i<mutaCount; i++) {
        BaseFormModel* m=[self.model.combination_arr objectAtIndex:i];
        CGFloat va=[m.value doubleValue];
        totalArea=totalArea*va;
    }
    BaseFormModel* last=[self.model.combination_arr lastObject];
    NSNumberFormatter* forma=[[NSNumberFormatter alloc]init];
    forma.numberStyle=NSNumberFormatterDecimalStyle;
    last.value=[NSString stringWithFormat:@"%.2f",totalArea];
    self.result.text=last.value;//[forma stringFromNumber:[NSNumber numberWithFloat:last.value.doubleValue]];
    

}

@end
