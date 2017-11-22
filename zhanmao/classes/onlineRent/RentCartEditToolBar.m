//
//  RentCartEditToolBar.m
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentCartEditToolBar.h"

@implementation RentCartEditToolBar

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.actionButton setBackgroundColor:_mainColor];
    [self.actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.actionButton.layer setCornerRadius:3];
    
    self.editing=NO;
}

- (IBAction)selectAllButtonClicked:(id)sender {
}

- (IBAction)actionButtonClicked:(id)sender {
}

-(void)setEditing:(BOOL)editing
{
    _editing=editing;
//    self.moneyBg.hidden=editing;
    
    NSString* str=editing?@"删除":@"租赁";
    [self.actionButton setTitle:str forState:UIControlStateNormal];
}

-(void)setSeletedAll:(BOOL)seletedAll
{
    _seletedAll=seletedAll;
    
    self.selectAllButton.selected=seletedAll;
//    NSString* imgN=seletedAll?@"icon_search":@"eyeGray";
//    [self.selectAllButton setImage:[UIImage imageNamed:imgN] forState:UIControlStateNormal];
}

-(void)setRentValue:(CGFloat)rentValue
{
    _rentValue=rentValue;
    self.rent.text=[NSString stringWithFormat:@"¥%.02f",rentValue];
}

-(void)setDepositValue:(CGFloat)depositValue
{
    _depositValue=depositValue;
    self.deposit.text=[NSString stringWithFormat:@"¥%.02f",depositValue];
}

@end
