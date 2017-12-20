//
//  TravellingRootViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TravellingRootViewController.h"
#import "LargeImageBlackLabelTableViewCell.h"
#import "FourButtonsTableViewCell.h"

#import "TravellingQuestionsViewController.h"

#import "TravellingHttpTool.h"

typedef NS_ENUM(NSInteger,TravellingSection)
{
    TravellingSectionHeaders,
    TravellingSectionTotalCount,
};


@interface TravellingRootViewController ()<SimpleButtonsTableViewCellDelegate>
{
    NSArray* arrayWithSimpleButtons;
    NSMutableArray* topProvidersArray;
}
@end

@implementation TravellingRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商旅";
    [self showLoadMoreView];
    [self refresh];
}

#pragma mark refresh and loadmore

-(void)refresh
{
    [TravellingHttpTool getAdvertisementsByCid:@"1" cache:NO success:^(NSArray *result) {
        self.advsArray=[NSMutableArray arrayWithArray:result];
        NSMutableArray* pics=[NSMutableArray array];
        for (TravellingModel* ad in self.advsArray) {
            NSString* th=ad.thumb;
            NSString* fu=[ZZUrlTool fullUrlWithTail:th];
            [pics addObject:fu];
        }
        if (result.count>0) {
            [self setAdvertiseHeaderViewWithPicturesUrls:pics];
        }
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    [TravellingHttpTool getServiceProviderType:@"1" page:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        NSMutableArray* models=[NSMutableArray array];
        for (TravellingModel* mo in result) {
            SimpleButtonModel* sim=[[SimpleButtonModel alloc]init];
            sim.identifier=mo.url;
            sim.imageName=[ZZUrlTool fullUrlWithTail:mo.thumb];
            sim.title=mo.name;
            [models addObject:sim];
        }
        arrayWithSimpleButtons=models;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    [TravellingHttpTool getServiceProviderType:@"2" page:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=1;
        }
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

-(void)loadMore
{
    [TravellingHttpTool getServiceProviderType:@"2" page:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViews

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section>TravellingSectionTotalCount) {
        return 10;
    }
    return 0.0001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count+TravellingSectionTotalCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section<TravellingSectionTotalCount)
    {
        return 2;
    }
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==0) {
        if (row==0) {
            FourButtonsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"FourButtonsTableViewCell" forIndexPath:indexPath];
            [cell setButtons:arrayWithSimpleButtons];
            [cell setDelegate:self];
            return cell;
        }
        else
        {
            UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MoreHeaderCell" forIndexPath:indexPath];
            return cell;
        }
    }
    else
    {
        sec=sec-TravellingSectionTotalCount;
        LargeImageBlackLabelTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"LargeImageBlackLabelTableViewCell" forIndexPath:indexPath];
        TravellingModel* obj=[self.dataSource objectAtIndex:sec];
        cell.title.text=obj.name;
        cell.detail.text=obj.provider;
        [cell.image sd_setImageWithURL:[obj.thumb urlWithMainUrl]];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sec=indexPath.section;
    sec=sec-TravellingSectionTotalCount;
    if (sec>=0&&sec<self.dataSource.count) {
        TravellingModel* mo=[self.dataSource objectAtIndex:sec];
        [self gotoUrl:mo.url];
    }
}

#pragma mark advertiseview delegate

-(void)advertiseView:(AdvertiseView *)adver didSelectedIndex:(NSInteger)index
{
    TravellingModel* mo=[self.advsArray objectAtIndex:index];
    [self gotoUrl:mo.url];
}

#pragma mark simplebuttonstableviewcell delegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    [self gotoUrl:model.identifier];
}

#pragma mark actions

-(void)gotoUrl:(NSString*)url
{
    NSLog(@"url%@",url);
    if (url.length>0) {
        TravellingQuestionsViewController* ques=[[TravellingQuestionsViewController alloc]init];
        ques.completionBlock=^(){
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        };
        [self.navigationController pushViewController:ques animated:YES];
    }
}

@end
