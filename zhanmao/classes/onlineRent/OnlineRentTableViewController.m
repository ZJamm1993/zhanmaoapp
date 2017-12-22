//
//  OnlineRentTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OnlineRentTableViewController.h"

#import "RentHttpTool.h"

//#import "ProductDetailViewController.h"
#import "ProductWebDetailViewController.h"
#import "RentCartTableViewController.h"
#import "NaviController.h"

#import "SimpleTitleTableViewCell.h"
#import "GoodsTableViewCell.h"
#import "MenuHeaderTableViewCell.h"

#import "ImageTitleBarButtonItem.h"
#import "ImageBadgeBarButtonItem.h"
#import "ZZSearchBar.h"

#import "BaseLoadMoreFooterView.h"

const CGFloat categoriesHeaderHeight=50;

@interface OnlineRentTableViewController ()<UITableViewDelegate,UITableViewDataSource,MenuHeaderTableViewCellDelegate,UITextFieldDelegate,BaseLoadMoreFooterViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *goodsTableView;
@property (weak, nonatomic) IBOutlet UITableView *catesTableView;

@end

@implementation OnlineRentTableViewController
{
    NSMutableArray* categoriesArray;
    NSMutableArray* goodsArray;
    NSMutableArray<MenuHeaderButtonModel*>* menuHeaderButtonModels;
    BaseLoadMoreFooterView* loadmoreFooter;
    UIRefreshControl* refreshControl;
    NSInteger currentPage;
    
    RentClass* selectedClass;
    NSString* sortString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"在线租赁";
//    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    
    
    [self selectLocation];
    
    ZZSearchBar* searchBar=[ZZSearchBar defaultBar];
    searchBar.placeholder=@"请输入您想要的商品";
    searchBar.delegate=self;
    CGRect fr=searchBar.frame;
//    fr.size.width=self.view.frame.size.width-140;
    searchBar.frame=fr;
//    searchBar.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5];
    self.navigationItem.titleView=searchBar;
    
    menuHeaderButtonModels=[NSMutableArray arrayWithObjects:
                            [MenuHeaderButtonModel modelWithTitle:@"日期" selected:NO ordered:YES ascending:NO ascendingString:@"post_modified_a" descendingString:@"post_modified_d"],
                            [MenuHeaderButtonModel modelWithTitle:@"价格" selected:NO ordered:YES ascending:NO ascendingString:@"rent_a" descendingString:@"rent_d"],
                            [MenuHeaderButtonModel modelWithTitle:@"销量" selected:NO ordered:NO ascending:NO ascendingString:@"post_hits_a" descendingString:@"post_hits_d"], nil];
    
    self.catesTableView.showsVerticalScrollIndicator=NO;
    self.catesTableView.scrollsToTop=NO;
    self.catesTableView.tableFooterView=[[UIView alloc]init];
    
    [self.goodsTableView registerClass:[MenuHeaderTableViewCell class] forHeaderFooterViewReuseIdentifier:@"MenuHeaderTableViewCell"];
    [self.goodsTableView setTableFooterView:[[UIView alloc]init]];
    
    self.goodsTableView.rowHeight=UITableViewAutomaticDimension;
    self.goodsTableView.estimatedRowHeight=100;
    
    loadmoreFooter=[BaseLoadMoreFooterView defaultFooter];
    self.goodsTableView.tableFooterView=loadmoreFooter;
    loadmoreFooter.delegate=self;
    
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.goodsTableView addSubview:refreshControl];
    
    //preset "all" category
    RentClass* allClass=[[RentClass alloc]init];
    allClass.cid=@"0";
    allClass.name=@"全部";
    categoriesArray=[NSMutableArray array];
    [categoriesArray addObject:allClass];
    [self.catesTableView reloadData];
    NSIndexPath* zeroIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.catesTableView selectRowAtIndexPath:zeroIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self tableView:self.catesTableView didSelectRowAtIndexPath:zeroIndexPath];
    
    //will not call delegate...
    
    [RentHttpTool getClasses:^(NSArray *result) {
        categoriesArray=[NSMutableArray arrayWithArray:result];
        [self.catesTableView reloadData];
        if(result.count>0)
        {
            NSIndexPath* zeroIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.catesTableView selectRowAtIndexPath:zeroIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
//            [self tableView:self.catesTableView didSelectRowAtIndexPath:zeroIndexPath];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [RentHttpTool getRentCartsCountSuccess:^(NSInteger count) {
        ImageBadgeBarButtonItem* cartItem=[ImageBadgeBarButtonItem itemWithImageName:@"cart" count:count target:self selector:@selector(cartItemClicked)];
        self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:cartItem, nil];
    } userid:[UserModel getUser].cartId failure:nil];
    
}

#pragma mark refresh adn load more

-(void)refresh{
    [RentHttpTool getGoodListByCid:selectedClass.cid sort:sortString page:1 pageSize:[RentHttpTool pagesize] cached:NO success:^(NSArray *result) {
        goodsArray=[NSMutableArray arrayWithArray:result];
        if (goodsArray.count>0) {
            currentPage=1;
        }
        [self.goodsTableView reloadData];
        [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    } failure:^(NSError *error) {
        [refreshControl endRefreshing];
    }];
}

-(void)loadmore{
    [RentHttpTool getGoodListByCid:selectedClass.cid sort:sortString page:currentPage+1 pageSize:[RentHttpTool pagesize] cached:NO success:^(NSArray *result) {
        [goodsArray addObjectsFromArray:result];
        if (result.count>0) {
            currentPage++;
            [loadmoreFooter endLoadingWithText:@"加载更多"];
        }
        else
        {
            [loadmoreFooter endLoadingWithText:@"到底了"];
        }
        [self.goodsTableView reloadData];
    } failure:^(NSError *error) {
        [loadmoreFooter endLoadingWithText:@""];
    }];
}

-(void)loadMoreFooterViewShouldStartLoadMore:(BaseLoadMoreFooterView *)footerView
{
    footerView.loading=YES;
    [self loadmore];
}

#pragma mark actions

-(void)setLocation:(NSString*)location
{
    ImageTitleBarButtonItem* it=[ImageTitleBarButtonItem itemWithImageName:@"downArrowSmall" leftImage:NO title:location target:self selector:@selector(selectLocation)];
    self.navigationItem.leftBarButtonItem=it;
}

-(void)selectLocation
{
    NSLog(@"select location");
    [self setLocation:@"广州"];
}

-(void)goSearch
{
    UIViewController* sear=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductSearchTableViewController"];
    UINavigationController* nav=[[NaviController alloc]initWithRootViewController:sear];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)cartItemClicked
{
//    ImageBadgeBarButtonItem* cartItem=[ImageBadgeBarButtonItem itemWithImageName:@"a" count:arc4random()%120 target:self selector:@selector(cartItemClicked)];
//    self.navigationItem.rightBarButtonItem=cartItem;
    
    RentCartTableViewController* rent=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"RentCartTableViewController"];
    [self.navigationController pushViewController:rent animated:YES];
}

#pragma mark textfielddelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self goSearch];
    return NO;
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.goodsTableView) {
        return goodsArray.count;
    }
    else if(tableView==self.catesTableView)
    {
        return categoriesArray.count;//categoriesArray.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.catesTableView) {
        SimpleTitleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SimpleTitleTableViewCell" forIndexPath:indexPath];
        RentClass* cla=[categoriesArray objectAtIndex:indexPath.row];
        cell.title.text=cla.name;
        return cell;
    }
    else if(tableView==self.goodsTableView)
    {
        GoodsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GoodsTableViewCell" forIndexPath:indexPath];
        RentProductModel* pro=[goodsArray objectAtIndex:indexPath.row];
        
        cell.title.text=pro.post_title;
        cell.count.text=[NSString stringWithFormat:@"%ld",(long) pro.post_hits];
        [cell.image sd_setImageWithURL:[pro.thumb urlWithMainUrl]];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.catesTableView) {
        NSLog(@"%@ selected: %@",@"catesTableView",indexPath);
        selectedClass=[categoriesArray objectAtIndex:indexPath.row];
        [self refresh];
    }
    else if(tableView==self.goodsTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ProductWebDetailViewController* prod=[[ProductWebDetailViewController alloc]init];
        prod.goodModel=[goodsArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:prod animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.catesTableView) {
        return categoriesHeaderHeight;
    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.goodsTableView) {
        return categoriesHeaderHeight;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.goodsTableView) {
        MenuHeaderTableViewCell* header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MenuHeaderTableViewCell"];
        header.buttonModelArray=menuHeaderButtonModels;
        header.delegate=self;
        return header;
    }
    return nil;
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

@end
