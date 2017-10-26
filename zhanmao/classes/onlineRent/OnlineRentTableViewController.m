//
//  OnlineRentTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OnlineRentTableViewController.h"

#import "ProductDetailViewController.h"
#import "RentCartViewController.h"

#import "SimpleTitleTableViewCell.h"
#import "GoodsTableViewCell.h"
#import "MenuHeaderTableViewCell.h"

#import "ImageBadgeBarButtonItem.h"
#import "ZZSearchBar.h"

const CGFloat categoriesHeaderHeight=60;

@interface OnlineRentTableViewController ()<UITableViewDelegate,UITableViewDataSource,MenuHeaderTableViewCellDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *goodsTableView;
@property (weak, nonatomic) IBOutlet UITableView *catesTableView;

@end

@implementation OnlineRentTableViewController
{
    NSMutableArray* categoriesArray;
    NSMutableArray* goodsArray;
    NSMutableArray<MenuHeaderButtonModel*>* menuHeaderButtonModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    ImageBadgeBarButtonItem* cartItem=[ImageBadgeBarButtonItem itemWithImageName:@"a" count:999 target:self selector:@selector(cartItemClicked)];
    self.navigationItem.rightBarButtonItem=cartItem;
    
    ZZSearchBar* searchBar=[ZZSearchBar defaultBar];
    searchBar.placeholder=@"请输入您想要的商品";
    searchBar.delegate=self;
    self.navigationItem.titleView=searchBar;
    
    menuHeaderButtonModels=[NSMutableArray arrayWithObjects:
                            [MenuHeaderButtonModel modelWithTitle:@"日期" selected:NO ordered:YES ascending:NO],
                            [MenuHeaderButtonModel modelWithTitle:@"价格" selected:NO ordered:YES ascending:NO],
                            [MenuHeaderButtonModel modelWithTitle:@"销量" selected:NO ordered:NO ascending:NO], nil];
    
    [self.catesTableView registerNib:[UINib nibWithNibName:@"SimpleTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"SimpleTitleTableViewCell"];
    self.catesTableView.showsVerticalScrollIndicator=NO;
    self.catesTableView.scrollsToTop=NO;
    
    [self.goodsTableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"GoodsTableViewCell"];
    [self.goodsTableView registerClass:[MenuHeaderTableViewCell class] forHeaderFooterViewReuseIdentifier:@"MenuHeaderTableViewCell"];
    
    self.goodsTableView.rowHeight=UITableViewAutomaticDimension;
    self.goodsTableView.estimatedRowHeight=100;
    
    NSIndexPath* zeroIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.catesTableView selectRowAtIndexPath:zeroIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self tableView:self.catesTableView didSelectRowAtIndexPath:zeroIndexPath];
    //will not call delegate...
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductSearchTableViewController"] animated:YES];
    return NO;
}

-(void)cartItemClicked
{
//    ImageBadgeBarButtonItem* cartItem=[ImageBadgeBarButtonItem itemWithImageName:@"a" count:arc4random()%120 target:self selector:@selector(cartItemClicked)];
//    self.navigationItem.rightBarButtonItem=cartItem;
    
    RentCartViewController* rent=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"RentCartViewController"];
    [self.navigationController pushViewController:rent animated:YES];
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.goodsTableView) {
        return 10;//goodsArray.count;
    }
    else if(tableView==self.catesTableView)
    {
        return 20;//categoriesArray.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.catesTableView) {
        SimpleTitleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SimpleTitleTableViewCell" forIndexPath:indexPath];
        cell.title.text=[NSString stringWithFormat:@"全部分类%ld",(long)indexPath.row];
        return cell;
    }
    else if(tableView==self.goodsTableView)
    {
        GoodsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"GoodsTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.catesTableView) {
        NSLog(@"%@ selected: %@",@"catesTableView",indexPath);
    }
    else if(tableView==self.goodsTableView)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        ProductDetailViewController* prod=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
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
    
    //do somethings
}

@end
