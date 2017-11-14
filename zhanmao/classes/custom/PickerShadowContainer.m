//
//  PickerShadowContainer.m
//  yangsheng
//
//  Created by Macx on 17/7/20.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "PickerShadowContainer.h"

@implementation PickerShadowContainer

+(void)showPickerContainerWithView:(UIView *)view
{
    [self showPickerContainerWithView:view completion:nil];
}

+(void)showPickerContainerWithView:(UIView *)view completion:(void (^)())completion
{
    [self showPickerContainerWithView:view title:@"" completion:completion];
}

+(void)showPickerContainerWithView:(UIView *)view title:(NSString*)title completion:(void (^)())completion
{
    PickerShadowContainer* p=[[PickerShadowContainer alloc]initWithFrame:[UIScreen mainScreen].bounds];
    p.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    
    CGRect windowBounds=[UIScreen mainScreen].bounds;
    [[[UIApplication sharedApplication]keyWindow] addSubview:p];
    
    [view removeFromSuperview];
    CGFloat hv=view.bounds.size.height;
    CGFloat barH=44;
    CGFloat bgH=hv+barH;
    CGFloat ww=windowBounds.size.width;
    CGFloat wh=windowBounds.size.height;
    
    UIView* bg=[[UIView alloc]initWithFrame:CGRectMake(0,wh,ww, bgH)];
    [p addSubview:bg];
    
    UIView* bar=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ww, barH)];
    bar.backgroundColor=[UIColor whiteColor];
    [bg addSubview:bar];
    
    UIButton* ok=[[UIButton alloc]initWithFrame:CGRectMake(ww-64, 0, 64, barH)];
    [ok setTitle:@"确定" forState:UIControlStateNormal];
    [ok.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [ok setTitleColor:_mainColor forState:UIControlStateNormal];
    [ok addTarget:p action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:ok];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ok.frame.origin.x, barH)];
    label.text=title;
    label.textColor=gray_2;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:17];
    [bar addSubview:label];
    
    [view removeFromSuperview];
    view.frame=CGRectMake(0, barH, ww, bgH-barH);
    //    view.backgroundColor=[UIColor whiteColor];
    [bg addSubview:view];
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, barH, ww, 0.5)];
    line.backgroundColor=[UIColor lightGrayColor];
    [bg addSubview:line];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect fr=bg.frame;
        fr.origin.y=wh-fr.size.height;
        bg.frame=fr;
    }];
    p.completionBlock=completion;
}

-(void)hide:(UIView*)view
{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect fr=view.frame;
        fr.origin.y=[UIScreen mainScreen].bounds.size.height;
        view.frame=fr;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

-(void)ok
{
    
    if (self.completionBlock) {
        self.completionBlock();
    }
    [self removeAllSubviews];
    [self removeFromSuperview];
}

-(void)removeFromSuperview
{
    [self removeAllSubviews];
    [super removeFromSuperview];
}

-(void)dealloc
{
    NSLog(@"picker shadow deal");
}

@end
