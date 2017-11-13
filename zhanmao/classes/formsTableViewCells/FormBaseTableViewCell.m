//
//  FormBaseTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "FormBaseTableViewCell.h"

@implementation FormBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
//        NSLog(@"%@",self);
        NSArray* subs=self.contentView.subviews;
        for(UIView* vi in subs)
        {
            if ([vi isKindOfClass:[UITextField class]]||[vi isKindOfClass:[UITextView class]])
            {
                [vi becomeFirstResponder];
            }
        }
    }
    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    BaseFormModel* oldModel=_model;
    NSString* oldValue=_model.oldValue;
    
    _model=model;
    
    BaseFormModel* newModel=model;
    NSString* newValue=model.value;
    
    if ((![oldValue isEqualToString:newValue])&&(oldModel==newModel)) {
        if ([self.delegate respondsToSelector:@selector(formBaseTableViewCellValueChanged:)]) {
            [self.delegate formBaseTableViewCellValueChanged:self];
        }
    }
    
}

-(void)reloadModel
{
    self.model=self.model;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self beginEditing];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self performSelector:@selector(textChanged:) withObject:textField afterDelay:0.01];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self beginEditing];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    [self performSelector:@selector(textChanged:) withObject:textView afterDelay:0.01];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self performSelector:@selector(valueChanged) withObject:nil afterDelay:0.1];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self performSelector:@selector(valueChanged) withObject:nil afterDelay:0.1];
}

-(void)beginEditing{
    if([self.delegate respondsToSelector:@selector(formBaseTableViewCellWillBeginEditing:)])
    {
        [self.delegate formBaseTableViewCellWillBeginEditing:self];
    }
}

-(void)valueChanged
{
    NSLog(@"%@ valueChanged, please overwrite",self);
}

-(void)textChanged:(id)someTextingView;
{
    if ([someTextingView respondsToSelector:@selector(text)]) {
        NSString* text=[someTextingView text];
        if ([text respondsToSelector:@selector(length)]) {
            if ([self respondsToSelector:@selector(placeHolder)]) {
                UILabel* pla=[self performSelector:@selector(placeHolder)];
                if ([pla isKindOfClass:[UILabel class]]) {
                    pla.hidden=text.length>0;
                }
            }
        }
    }
    
}

-(id)placeHolder
{
    return nil;
}

@end
