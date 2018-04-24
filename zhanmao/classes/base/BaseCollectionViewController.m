//
//  BaseCollectionViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "BaseLoadMoreFooterView.h"

@interface BaseCollectionViewController ()<BaseLoadMoreFooterViewDelegate>
{
    NSInteger lastCount;
    BaseLoadMoreFooterView* loadMoreFooter;
}

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shouldLoadMore=YES;
    
//    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    [self.collectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadSectionsNotification:) name:UICollectionViewReloadSectionsNotification object:nil];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.bounces=YES;
    self.collectionView.alwaysBounceVertical=YES;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"f"];
    
//    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"",@""]];
    // Do any additional setup after loading the view.
    
//    [self showLoadMoreView];
    self.collectionView.backgroundColor=[UIColor whiteColor];
}

-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}




-(void)reloadSectionsNotification:(NSNotification*)notification
{
    NSDictionary* userDef=notification.userInfo;
    UICollectionView* collecVi=[userDef valueForKey:@"collectionView"];
    if (collecVi==self.collectionView) {

        NSLog(@"%@ reloaded sections",NSStringFromClass([self class]));
        [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];

        NSString* loadmoreText=@"";
        if (lastCount==self.dataSource.count&&!self.refreshControl.refreshing) {
            loadmoreText=@"";
        }
        [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:loadmoreText afterDelay:1];
        lastCount=self.dataSource.count;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ deal",NSStringFromClass([self class]));
}

#pragma mark - Refresh And Load More

-(void)firstLoad
{
    
}

-(void)refresh
{
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    [self.collectionView reloadData];
}

-(void)loadMore
{
    [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:@"" afterDelay:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    view.layer.zPosition = 0.0;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGRect frame = scrollView.frame;
    CGSize contentSize=scrollView.contentSize;
    
    CGFloat maa=20;
    
    if (contentOffset.y >= contentSize.height - frame.size.height -maa || contentSize.height < frame.size.height-maa)
    {
        if (loadMoreFooter.loading==NO&&loadMoreFooter&&self.shouldLoadMore) {
            NSLog(@"should loadmore");
            [self loadMoreFooterViewShouldStartLoadMore:loadMoreFooter];
        }
    }
}


#pragma mark - loadmore something

-(void)showLoadMoreView
{
    if (loadMoreFooter==nil) {
        loadMoreFooter=[BaseLoadMoreFooterView defaultFooter];
        loadMoreFooter.delegate=self;
    }
}

-(void)hideLoadMoreView
{
    loadMoreFooter=nil;
}

-(void)loadMoreFooterViewShouldStartLoadMore:(BaseLoadMoreFooterView *)footerView
{
    footerView.loading=YES;
    [self loadMore];
}

@end
