//
//  SimpleButtonsTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "SimpleButtonsTableViewCell.h"

const CGFloat simpleButtonMarginY=14;
const CGFloat simpleButtonHeight=78;
const NSInteger simpleButtonRowCount=4;

@implementation SimpleButtonsTableViewCell

+(CGFloat)heightWithButtonsCount:(NSInteger)count
{
    NSInteger rows=count/simpleButtonRowCount;
    if (count%simpleButtonRowCount>0) {
        rows=rows+1;
    }
    CGFloat he=(simpleButtonHeight+simpleButtonMarginY)*rows+simpleButtonMarginY;
    return he;
}

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    _buttons=buttons;
    [self.contentView removeAllSubviews];
    
    CGFloat totalWidth=[[UIScreen mainScreen]bounds].size.width;
    CGFloat widthPerEach=totalWidth/simpleButtonRowCount;
//    CGFloat widthPerEach_2=widthPerEach/2;
    CGFloat heightPerEach=simpleButtonHeight;
//    CGFloat height_2=heightPerEach/2;
    
    CGFloat titleHeight=15;
    CGFloat imageHeight=heightPerEach-titleHeight-10;
    
    NSInteger counts=buttons.count;
    for (NSInteger i=0; i<counts; i++) {
        NSInteger col=i%simpleButtonRowCount;
        NSInteger row=i/simpleButtonRowCount;
        SimpleButtonModel* mo=[buttons objectAtIndex:i];
//        NSLog(@"%d,%d",col,row);
        UIView* bbg=[[UIView alloc]initWithFrame:CGRectMake(col*widthPerEach, row*(heightPerEach+simpleButtonMarginY)+simpleButtonMarginY, widthPerEach, heightPerEach)];
        bbg.backgroundColor=_randomColor;
        [self.contentView addSubview:bbg];
        
        UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, heightPerEach-titleHeight, widthPerEach, titleHeight)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font=[UIFont systemFontOfSize:14];
        titleLabel.text=mo.title;
        [bbg addSubview:titleLabel];
        
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthPerEach, imageHeight)];
        imageView.backgroundColor=_randomColor;
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.image=[UIImage imageNamed:mo.imageName];
        [bbg addSubview:imageView];
        
        UIButton* btn=[[UIButton alloc]initWithFrame:bbg.bounds];
        btn.tag=i;
        [btn addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
        [bbg addSubview:btn];
    }
}

-(void)buttonClicks:(UIButton*)button
{
    NSInteger tag=button.tag;
    SimpleButtonModel* mo=[self.buttons objectAtIndex:tag];
//    NSLog(@"%@,%@",mo.title,mo.identifier);
    if([self.delegate respondsToSelector:@selector(simpleButtonsTableViewCell:didSelectedModel:)])
    {
        [self.delegate simpleButtonsTableViewCell:self didSelectedModel:mo];
    }
}

@end

@implementation SimpleButtonModel

-(instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName identifier:(NSString *)identifier
{
    self=[super init];
    if (self) {
        self.title=title;
        self.imageName=imageName;
        self.identifier=identifier;
    }
    return self;
}

@end
