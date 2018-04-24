//
//  BaseCollectionViewController.h
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray* dataSource;

@property (nonatomic,assign) BOOL shouldLoadMore;

@property (nonatomic,strong) UIRefreshControl* refreshControl;

-(void)firstLoad;
-(void)refresh;

-(void)loadMore;

-(void)showLoadMoreView;
-(void)hideLoadMoreView;

@end
