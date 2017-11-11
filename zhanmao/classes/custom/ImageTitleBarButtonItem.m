//
//  ImageTitleBarButtonItem.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ImageTitleBarButtonItem.h"

@implementation ImageTitleBarButtonItem

+(instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIImageView* img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    img.frame=CGRectMake(0, 0, 30, 30);
    img.contentMode=UIViewContentModeCenter;
    [img sizeToFit];
    img.frame=CGRectMake(0, 0, img.frame.size.width, 30);
    
    UILabel* lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img.frame)+10, 0, 100, CGRectGetMaxY(img.frame))];
    lab.text=title;
    lab.textColor=[UIColor whiteColor];
    lab.font=[UIFont systemFontOfSize:15];
    [lab sizeToFit];
    lab.frame=CGRectMake(CGRectGetMaxX(img.frame)+4, 0, lab.frame.size.width, CGRectGetMaxY(img.frame));
    
    UIButton* v=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(lab.frame), CGRectGetMaxY(lab.frame))];
    [v addSubview:img];
    [v addSubview:lab];
    [v addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    ImageTitleBarButtonItem* item=[[ImageTitleBarButtonItem alloc]initWithCustomView:v];
//    item.target=target;
//    item.action=selector;
    return item;
}

@end
