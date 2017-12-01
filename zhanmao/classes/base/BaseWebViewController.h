//
//  BaseWebViewController.h
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

#define GoodsShowDetail @"/Mall/Goods/show"

@interface BaseWebViewController : BaseViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,assign) NSInteger idd;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong) UIView* webUIView;

@property (nonatomic,strong) UIView* bottomView;
@property (nonatomic,assign) CGRect bottomBgBounds;

@property (nonatomic,strong) NSMutableDictionary* params;

@end
