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
    
}
@end

@implementation ProductSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addTipsViewIfNeed];
    
//    tip=[SearchTipsView searchTipsViewWithRecentlyStrings:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] trendyString:@[@"1-",@"2-",@"3-",@"4-",@"5-",@"6-"] delegate:self];
//    [self.tableView addSubview:tip];
    
    searchBar=[ZZSearchBar defaultBar];
    searchBar.delegate=self;
    CGRect fr=searchBar.frame;
//    fr.size.width=self.view.frame.size.width-64;
    searchBar.frame=fr;
    searchBar.tintColor=_mainColor;
    self.navigationItem.titleView=searchBar;
    searchBar.placeholder=@"请输入您想要的商品";
    [searchBar becomeFirstResponder];
    
    UIBarButtonItem* searchBtn=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem=searchBtn;
    
    menuHeaderButtonModels=[NSMutableArray arrayWithObjects:
                            [MenuHeaderButtonModel modelWithTitle:@"日期" selected:NO ordered:YES ascending:NO ascendingString:@"post_modified_a" descendingString:@"post_modified_d"],
                            [MenuHeaderButtonModel modelWithTitle:@"价格" selected:NO ordered:YES ascending:NO ascendingString:@"rent_a" descendingString:@"rent_d"],
                            [MenuHeaderButtonModel modelWithTitle:@"销量" selected:NO ordered:NO ascending:NO ascendingString:@"post_hits_a" descendingString:@"post_hits_d"], nil];
    [self.tableView registerClass:[MenuHeaderTableViewCell class] forHeaderFooterViewReuseIdentifier:@"MenuHeaderTableViewCell"];
    
    [self showLoadMoreView];
}



-(void)addTipsViewIfNeed
{
    if (tip) {
        [tip removeFromSuperview];
    }
    [RentHttpTool getSearchedStrings:^(NSArray *result) {
        if (result.count>0) {
            searchedStrings=result;
            
            tip=[SearchTipsView searchTipsViewWithRecentlyStrings:searchedStrings trendyString:nil delegate:self];
            [self.tableView performSelector:@selector(addSubview:) withObject:tip afterDelay:0];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self refresh];
}

#pragma refresh and loadmore

-(void)refresh{
//    [self.dataSource removeAllObjects];
//    [self.tableView reloadData];
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
    ProductWebDetailViewController* prod=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductWebDetailViewController"];
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
