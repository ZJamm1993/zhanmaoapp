//
//  BaseWebViewController.h
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseViewController.h"

#define HTML_GoodsShowDetail @"/themes/simplebootx/Mall/goods_show.html"
#define HTML_BugProtocol @"/Content/Page/bugprotocol"
#define HTML_HelpDetail @"/Content/Help/show"
#define HTML_NewsDetail @"/themes/simplebootx/Content/news.html"
#define HTML_ExhiDetail @"/themes/simplebootx/Content/exhibition_detail.html"

@interface BaseWebViewController : BaseViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,assign) NSInteger idd;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong) UIView* webUIView;

@property (nonatomic,weak) UIView* bottomView;
@property (nonatomic,assign) CGRect bottomBgBounds;
@property (nonatomic,assign,readonly) CGFloat bottomSafeInset;

@property (nonatomic,strong) NSMutableDictionary* params;

@end
