//
//  ProductSearchTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ProductSearchTableViewController.h"
#import "SearchTipsView.h"
#import "ZZSearchBar.h"

#import "MenuHeaderTableViewCell.h"
#import "GoodsTableViewCell.h"
#import "ProductWebDetailViewController.h"

#import "RentHttpTool.h"

@interface ProductSearchTableViewController ()<SearchTipsViewDelegate,UITextFieldDelegate,MenuHeaderTableViewCellDelegate>
{
    SearchTipsView* tip;
    ZZSearchBar* searchBar;
    
    NSMutableArray<MenuHeaderButtonModel*>* menuHeaderButtonModels;
    NSString* sortString;
    NSString* searchingString;
    
    NSArray* searchedStrings;
    NSArray* trendStrings;
    
    CGFloat bottomSafe;
    
    CGRect tipsFrame;
}
@end

@implementation ProductSearchTableViewController

#if XcodeSDK11
-(void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    if ([self.view respondsToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets est=[self.view safeAreaInsets];
            bottomSafe=est.bottom;
            
            CGFloat maxY=0;
            for (UIView* sv in tip.subviews) {
                CGFloat my=CGRectGetMaxY(sv.frame);
                if (my>maxY) {
                    maxY=my;
                }
            }
            [tip setContentSize:CGSizeMake(tip.frame.size.width, maxY+bottomSafe)];
        } else {
            // Fallback on earlier versions
        }
    }
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    
    searchBar=[ZZSearchBar defaultBar];
    searchBar.delegate=self;
    CGRect fr=searchBar.frame;

    searchBar.frame=fr;
    searchBar.tintColor=_mainColor;
    self.navigationItem.titleView=searchBar;
    searchBar.placeholder=@"请输入您想要的商品";
    
    
    UIBarButtonItem* searchBtn=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem=searchBtn;
    
    menuHeaderButtonModels=[NSMutableArray arrayWithObjects:
                            [MenuHeaderButtonModel modelWithTitle:@"日期" selected:NO ordered:YES ascending:NO ascendingString:@"post_modified_a" descendingString:@"post_modified_d"],
                            [MenuHeaderButtonModel modelWithTitle:@"价格" selected:NO ordered:YES ascending:NO ascendingString:@"rent_a" descendingString:@"rent_d"],
                            [MenuHeaderButtonModel modelWithTitle:@"销量" selected:NO ordered:NO ascending:NO ascendingString:@"post_hits_a" descendingString:@"post_hits_d"], nil];
    [self.tableView registerClass:[MenuHeaderTableViewCell class] forHeaderFooterViewReuseIdentifier:@"MenuHeaderTableViewCell"];
    
    [self showLoadMoreView];
    
    tipsFrame=self.view.bounds;
    
    [self addTipsViewIfNeed];
    
    [RentHttpTool getHotestSearchedStrings:^(NSArray *res) {
        trendStrings=res;
        [self addTipsViewIfNeed];
    } failure:^(NSError *error) {
        
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHides:) name:UIKeyboardWillHideNotification object:nil];

    [searchBar becomeFirstResponder];
}

-(void)addTipsViewIfNeed
{
    NSArray* tableSubviews=self.tableView.subviews;
    for (UIView* sv in tableSubviews) {
        if ([sv isKindOfClass:[SearchTipsView class]]) {
            [sv removeFromSuperview];
        }
    }
    
    [RentHttpTool getSearchedStrings:^(NSArray *result) {

        searchedStrings=result;
            
        tip=[[SearchTipsView alloc]initWithFrame:tipsFrame];
        tip.delegate=self;
        [tip setRecentlyStrings:searchedStrings trendyString:trendStrings delegate:self];
        [self.tableView addSubview:tip];
        
        self.tableView.scrollEnabled=NO;
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark keyboards

-(void)keyboardShows:(NSNotification*)noti
{
    [self keyboardAnimationWithNotification:noti showing:YES];
}

-(void)keyboardHides:(NSNotification*)noti
{
    [self keyboardAnimationWithNotification:noti showing:NO];
}

-(void)keyboardAnimationWithNotification:(NSNotification*)noti showing:(BOOL)showing
{
    NSDictionary* userinfo=noti.userInfo;
    
    CGFloat frameY=[[userinfo valueForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    CGFloat animaD=[[userinfo valueForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:animaD animations:^{
        CGFloat tipsHeight=frameY-44-[[UIApplication sharedApplication]statusBarFrame].size.height;
        tipsFrame.size.height=tipsHeight;
        if (!showing) {
            tipsFrame=self.view.bounds;
        }
        [tip setFrame:tipsFrame];
    }];
}

#pragma mark search texting

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [searchBar resignFirstResponder];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self goSearchString:textField.text];
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self addTipsViewIfNeed];
    return YES;
}

-(void)goSearchString:(NSString*)str
{
    searchingString=str;
    [RentHttpTool addSearchedString:str success:nil failure:nil];
    [tip removeFromSuperview];
    self.tableView.scrollEnabled=YES;
    [self refresh];
}

#pragma refresh and loadmore

-(void)refresh{

    [RentHttpTool getGoodListSearchByKeyword:searchingString sort:sortString page:1 pageSize:[RentHttpTool pagesize] cached:NO success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        if (result.count>0) {
            self.currentPage=1;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

-(void)loadmore{
    [RentHttpTool getGoodListSearchByKeyword:searchingString sort:sortString page:self.currentPage+1 pageSize:[RentHttpTool pagesize] cached:NO success:^(NSArray *result) {
        [self.dataSource addObjectsFromArray:result];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GoodsTableViewCell" forIndexPath:indexPath];
    RentProductModel* pro=[self.dataSource objectAtIndex:indexPath.row];
    
    cell.title.text=pro.post_title;
    cell.count.text=[NSString stringWithFormat:@"%ld",(long) pro.post_hits];
    [cell.image sd_setImageWithURL:[pro.thumb urlWithMainUrl]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductWebDetailViewController* prod=[[ProductWebDetailViewController alloc]init];
    prod.goodModel=[self.dataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:prod animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MenuHeaderTableViewCell* header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MenuHeaderTableViewCell"];
    header.buttonModelArray=menuHeaderButtonModels;
    header.delegate=self;
    return header;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView==tip) {
        [searchBar resignFirstResponder];
    }
}

#pragma mark menuHeaderDelegate

-(void)menuHeaderTableViewCell:(MenuHeaderTableViewCell *)cell didChangeModels:(NSArray*)models
{
    menuHeaderButtonModels=[NSMutableArray arrayWithArray:models];
    
    for (MenuHeaderButtonModel* mo in models) {
        if (mo.selected) {
            if (![sortString isEqualToString:mo.sortString]) {
                
                sortString=mo.sortString;
                NSLog(@"%@",sortString);
                [self refresh];
            }
        }
    }
    
    //do somethings
}

#pragma mark tipsView delegate

-(void)searchTipsView:(SearchTipsView *)tipsview selectedString:(NSString *)string
{
    NSLog(@"%@",string);
    searchBar.text=string;
    [self goSearchString:string];
    [searchBar resignFirstResponder];
}

-(void)searchTipsViewDeleteAllSearchedStrings:(SearchTipsView *)tipsview
{
    [RentHttpTool removeSearchedStrings:nil failure:nil];
    [self addTipsViewIfNeed];
}


@end
