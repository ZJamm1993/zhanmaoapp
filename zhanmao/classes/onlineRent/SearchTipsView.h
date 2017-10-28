//
//  SearchTipsView.h
//  zhanmao
//
//  Created by bangju on 2017/10/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchTipsView;

@protocol SearchTipsViewDelegate <NSObject>

@optional
-(void)searchTipsView:(SearchTipsView*)tipsview selectedString:(NSString*)string;

@end

@interface SearchTipsView : UIView

@property (nonatomic,weak) id<SearchTipsViewDelegate>delegate;
@property (nonatomic,strong) NSArray* recentlyStrings;
@property (nonatomic,strong) NSArray* trendyStrings;

+(instancetype)searchTipsViewWithRecentlyStrings:(NSArray<NSString*>*)recently trendyString:(NSArray<NSString*>*)trendy delegate:(id<SearchTipsViewDelegate>)delegate;

@end
