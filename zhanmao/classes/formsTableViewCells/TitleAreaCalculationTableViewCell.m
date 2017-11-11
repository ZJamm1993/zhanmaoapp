//
//  TitleAreaCalculationTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleAreaCalculationTableViewCell.h"

@implementation TitleAreaCalculationTableViewCell

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
        CGFloat totalArea=1;
        for (NSInteger i=0; i<2; i++) {
            BaseFormModel* m=[model.combination_arr objectAtIndex:i];
            CGFloat va=[m.value floatValue];
            totalArea=totalArea*va;
        }
        BaseFormModel* last=[model.combination_arr lastObject];
        NSNumberFormatter* forma=[[NSNumberFormatter alloc]init];
        forma.numberStyle=NSNumberFormatterDecimalStyle;
        last.value=[NSString stringWithFormat:@"%f",totalArea];
        self.result.text=[forma stringFromNumber:[NSNumber numberWithFloat:last.value.floatValue]];
    }
    self.bottomResultView.hidden=!showingBottom;
    self.bottomResultViewHeight.constant=showingBottom?44:0;
}

-(void)textFieldChanged:(UITextField*)textField;
{
    if ([self.fields containsObject:textField]) {
        NSInteger ind=[self.fields indexOfObject:textField];
//        NSLog(@"%d,%@",ind,textField);
        if (self.model.combination_arr.count>ind) {
            BaseFormModel* mo=[self.model.combination_arr objectAtIndex:ind];
            mo.value=textField.text;
            self.model=self.model;
        }
    }
}

@end
