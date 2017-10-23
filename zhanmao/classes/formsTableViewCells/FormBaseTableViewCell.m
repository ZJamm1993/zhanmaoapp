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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self beginEditing];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
    return YES;
}

-(void)beginEditing{
    if([self.delegate respondsToSelector:@selector(formBaseTableViewCellWillBeginEditing:)])
    {
        [self.delegate formBaseTableViewCellWillBeginEditing:self];
    }

}

@end
