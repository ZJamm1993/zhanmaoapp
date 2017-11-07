//
//  RentActionEditView.m
//  zhanmao
//
//  Created by bangju on 2017/11/7.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentActionEditView.h"

@implementation RentActionEditView

+(instancetype)defaultView
{
    RentActionEditView* vi=[[[UINib nibWithNibName:@"RentActionEditView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    return vi;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cartBg.backgroundColor=[UIColor whiteColor];
    self.cartBg.layer.cornerRadius=4;
    
    self.darkBg.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
}

-(void)show
{
    [self removeFromSuperview];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    
    CGRect windRect=[[UIScreen mainScreen]bounds];
    CGRect orgRe=windRect;
    orgRe.origin.y=orgRe.size.height;
    
    self.frame=orgRe;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame=windRect;
    } completion:nil];
}

-(void)hide
{
    CGRect windRect=[[UIScreen mainScreen]bounds];
    CGRect orgRe=windRect;
    orgRe.origin.y=orgRe.size.height;
    
//    self.frame=orgRe;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame=orgRe;
    } completion:^(BOOL isFinish){
        
        [self removeFromSuperview];
    }];
}
- (IBAction)xPress:(id)sender {
    [self hide];
}



@end
