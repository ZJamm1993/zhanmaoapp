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
-(void)searchTipsViewDeleteAllSearchedStrings:(SearchTipsView *)tipsview;

@end

@interface SearchTipsView : UIScrollView

@property (nonatomic,weak) id<SearchTipsViewDelegate> tipsDelegate;
//@property (nonatomic,strong) NSArray* recentlyStrings;
@property (nonatomic,strong) NSArray* trendyStrings;

-(void)setRecentlyStrings:(NSArray<NSString*>*)recently trendyString:(NSArray<NSString*>*)trendy delegate:(id<SearchTipsViewDelegate>)delegate;

@end
