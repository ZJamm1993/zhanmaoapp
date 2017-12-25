//
//  SearchTipsView.m
//  zhanmao
//
//  Created by bangju on 2017/10/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "SearchTipsView.h"

@implementation SearchTipsView

-(void)setRecentlyStrings:(NSArray<NSString *> *)recently trendyString:(NSArray<NSString *> *)trendy delegate:(id<SearchTipsViewDelegate>)delegate
{
    SearchTipsView* view=self;
    
    view.showsVerticalScrollIndicator=NO;
    
    view.tipsDelegate=delegate;
    view.backgroundColor=[UIColor whiteColor];
    
    CGFloat m=10;
    
    CGFloat currentY=m;
    CGFloat currentX=m;
    
    if (recently.count>0) {
        currentY=[view addSectionsViewWithTitle:@"最近搜索" imageName:@"searchGraySmall" canBeDeleted:YES strings:recently currentX:currentX currentY:currentY margin:m];
    }
    if (trendy.count>0) {
        currentY=[view addSectionsViewWithTitle:@"热门搜索" imageName:@"searchHot" canBeDeleted:NO strings:trendy currentX:currentX currentY:currentY margin:m];
    }
    
    view.bounces=YES;
    view.alwaysBounceVertical=YES;
    
    view.contentSize=CGSizeMake(view.frame.size.width, currentY);
}

-(CGFloat)addSectionsViewWithTitle:(NSString*)title imageName:(NSString*)imgName canBeDeleted:(BOOL)canbedeleted strings:(NSArray*)strs currentX:(CGFloat)currentX currentY:(CGFloat)currentY margin:(CGFloat)m
{
    
    CGFloat rowHeight=28;
    CGFloat maxBtnWidth=self.frame.size.width-m-m-m;
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
        gr.size.width=maxBtnWidth;
        gr.size.height=rowHeight;
        btn.frame=gr;
        
        [btn sizeToFit];
        gr.size.height=rowHeight;
        gr.size.width=btn.frame.size.width+m;
        btn.frame=gr;
        
        [self addSubview:btn];
        
        // if current btn is out of bounds
        
        CGFloat testCurX=CGRectGetMaxX(gr);
        if (testCurX+m>self.frame.size.width) {
            if (gr.origin.x==m) {
                
            }
            else
            {
                gr.origin=CGPointMake(m, CGRectGetMaxY(gr)+m);
                btn.frame=gr;
                currentY=gr.origin.y;
            }
            
        }

        // if next btn.x is out of bounds
        
        currentX=CGRectGetMaxX(gr)+m;
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
    ti.textColor=gray_4;
    ti.font=[UIFont systemFontOfSize:14];
    [view addSubview:ti];
    
    if (canBeDeleted) {
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width-h, 0, h, h)];
        [btn setImage:[UIImage imageNamed:@"searchDelete"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    return view;
}

-(UIButton*)buttonWithString:(NSString*)string
{
    UIButton* bt=[[UIButton alloc]initWithFrame:CGRectZero];
    bt.layer.cornerRadius=4;
    bt.layer.borderColor=gray_4.CGColor;
    bt.layer.borderWidth=1/[[UIScreen mainScreen]scale];
    [bt setTitle:string forState:UIControlStateNormal];
    [bt.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [bt setTitleColor:gray_4 forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(stringButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return bt;
}

-(void)stringButtonClick:(UIButton*)btn
{
    NSString* str=[btn titleForState:UIControlStateNormal];
    if (str.length>0) {
        if ([self.tipsDelegate respondsToSelector:@selector(searchTipsView:selectedString:)]) {
            [self.tipsDelegate searchTipsView:self selectedString:str];
        }
    }
}

-(void)deleteButtonClick:(UIButton*)btn
{
    if ([self.tipsDelegate respondsToSelector:@selector(searchTipsViewDeleteAllSearchedStrings:)]) {
        [self.tipsDelegate searchTipsViewDeleteAllSearchedStrings:self];
    }
}

@end
