//
//  StepsHeaderView.m
//  zhanmao
//
//  Created by bangju on 2017/11/13.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "StepsHeaderView.h"

@implementation StepsHeaderView

+(instancetype)headerWithTitles:(NSArray *)titles currentStep:(NSInteger)step
{
    StepsHeaderView* heaer=[[StepsHeaderView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 72)];
    heaer.backgroundColor=[UIColor whiteColor];
    
    CGFloat margX=[[UIScreen mainScreen]bounds].size.width/(2+(titles.count-1)*2);
    CGFloat margY=heaer.frame.size.height/3;
    
    UIView* bg=[[UIView alloc]initWithFrame:CGRectMake(margX, 0, heaer.frame.size.width-margX*2, heaer.frame.size.height)];
    [heaer addSubview:bg];
    bg.clipsToBounds=NO;
    
    NSInteger count=titles.count;
    
    if (count<=1) {
        return heaer;
    }
    
    CGFloat lineMargX=8;
    CGFloat dotXMargX=bg.frame.size.width/(count-1);
    CGFloat lineWidth=dotXMargX-lineMargX*2;
    
    CGFloat dotW=8;
    CGFloat lineH=2;
    
    for (NSInteger i=0; i<count; i++) {
        NSString* str=[titles objectAtIndex:i];
        
        UIView* dot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, dotW, dotW)];
        dot.backgroundColor=[UIColor groupTableViewBackgroundColor];
        dot.layer.cornerRadius=dot.frame.size.width/2;
        dot.center=CGPointMake(i*dotXMargX, margY);
        [bg addSubview:dot];
        
        UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        lab.textColor=gray_6;
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont systemFontOfSize:12];
        lab.text=str;
        lab.center=CGPointMake(dot.center.x, 2*margY);
        [bg addSubview:lab];
        
        UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, lineWidth, lineH)];
        line.backgroundColor=dot.backgroundColor;
        line.center=CGPointMake(dot.center.x-lineMargX-lineWidth/2, dot.center.y);
        line.hidden=(i==0);
        [bg addSubview:line];
        
        if (i<=step) {
            dot.backgroundColor=_mainColor;
            lab.textColor=_mainColor;
            line.backgroundColor=_mainColor;
        }
    }
    
    return heaer;
}

@end
