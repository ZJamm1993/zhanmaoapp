//
//  SearchTipsView.m
//  zhanmao
//
//  Created by bangju on 2017/10/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "SearchTipsView.h"

@implementation SearchTipsView

+(instancetype)searchTipsViewWithRecentlyStrings:(NSArray<NSString *> *)recently trendyString:(NSArray<NSString *> *)trendy delegate:(id<SearchTipsViewDelegate>)delegate
{
    SearchTipsView* view=[[SearchTipsView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.delegate=delegate;
    view.backgroundColor=[UIColor whiteColor];
    
    
    CGFloat m=10;
    
    CGFloat currentY=m;
    CGFloat currentX=m;
    
    if (recently.count>0) {
        currentY=[view addSectionsViewWithTitle:@"最近搜索" imageName:@"a" canBeDeleted:YES strings:recently currentX:currentX currentY:currentY margin:m];
    }
    if (trendy.count>0) {
        currentY=[view addSectionsViewWithTitle:@"热门搜索" imageName:@"a" canBeDeleted:NO strings:trendy currentX:currentX currentY:currentY margin:m];
    }
    
    return view;
}

-(CGFloat)addSectionsViewWithTitle:(NSString*)title imageName:(NSString*)imgName canBeDeleted:(BOOL)canbedeleted strings:(NSArray*)strs currentX:(CGFloat)currentX currentY:(CGFloat)currentY margin:(CGFloat)m
{
    
    CGFloat rowHeight=28;
    CGFloat colWidth=(self.frame.size.width-5*m)/4;
    UIView* titleView=[self titleViewWithImageName:imgName title:title showDelete:canbedeleted];
    CGRect fr=titleView.frame;
    fr.origin.x=currentX;
    fr.origin.y=currentY;
    titleView.frame=fr;
//    currentX=m;
    currentY=CGRectGetMaxY(fr)+m;
    [self addSubview:titleView];
    
    for (NSString* string in strs) {
        UIButton* btn=[self buttonWithString:string];
        CGRect gr=btn.frame;
        gr.origin.x=currentX;
        gr.origin.y=currentY;
        gr.size.width=colWidth;
        gr.size.height=rowHeight;
        btn.frame=gr;
        [self addSubview:btn];
        
        currentX=currentX+m+colWidth;
        if (currentX+m>=self.frame.size.width) {
            currentX=m;
            currentY=CGRectGetMaxY(gr)+m;
        }
        
    }
    
    if (currentX==m) {
        currentY=currentY+m;
    }
    else{
        currentY=currentY+rowHeight+m+m;
    }
    return currentY;
}

-(UIView*)titleViewWithImageName:(NSString*)imgName title:(NSString*)title showDelete:(BOOL)canBeDeleted
{
    CGFloat h=30;
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-20, h)];
    
    UIImageView* img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, h, h)];
    img.image=[UIImage imageNamed:imgName];
    img.contentMode=UIViewContentModeLeft;
    [view addSubview:img];
    
    UILabel* ti=[[UILabel alloc]initWithFrame:CGRectMake(h, 0, 200, h)];
    ti.text=title;
    ti.textColor=[UIColor darkGrayColor];
    ti.font=[UIFont systemFontOfSize:14];
    [view addSubview:ti];
    
    if (canBeDeleted) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-h, 0, h, h)];
        [btn setImage:[UIImage imageNamed:@"a"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    return view;
}

-(UIButton*)buttonWithString:(NSString*)string
{
    UIButton* bt=[[UIButton alloc]initWithFrame:CGRectZero];
    bt.layer.cornerRadius=2;
    bt.layer.borderColor=[UIColor lightGrayColor].CGColor;
    bt.layer.borderWidth=1/[[UIScreen mainScreen]scale];
    [bt setTitle:string forState:UIControlStateNormal];
    [bt.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [bt setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(stringButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return bt;
}

-(void)stringButtonClick:(UIButton*)btn
{
    NSString* str=[btn titleForState:UIControlStateNormal];
    if (str.length>0) {
        if ([self.delegate respondsToSelector:@selector(searchTipsView:selectedString:)]) {
            [self.delegate searchTipsView:self selectedString:str];
        }
    }
}

-(void)deleteButtonClick:(UIButton*)btn
{
    
}

@end
