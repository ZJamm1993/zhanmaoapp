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

-(void)refresh
{
    [TravellingHttpTool getAdvertisementsByCid:1 cache:NO success:^(NSArray *result) {
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
        
    }];
    
    [TravellingHttpTool getServiceProviderPage:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=1;
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadMore
{
    [TravellingHttpTool getServiceProviderPage:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)arrayWithSimpleButtons
{
    if (arrayWithSimpleButtons.count==0) {
        
//        NSMutableArray* array=[NSMutableArray array];
//        NSArray* tits=[NSArray arrayWithObjects:@"租赁订单",@"物流订单",@"保洁订单",@"定制订单", nil];
//        NSArray* imgs=[NSArray arrayWithObjects:@"orderRent",@"orderTransport",@"orderClean",@"orderCustom", nil];
//        NSArray* ides=[NSArray arrayWithObjects:@"RentOrderPagerViewController",@"TransportOrderPagerViewController",@"CleanOrderPagerViewController",@"CustomOrderPagerViewController", nil];
//        
//        for (NSInteger i=0; i<4; i++) {
//            SimpleButtonModel* mo=[[SimpleButtonModel alloc]initWithTitle:[tits objectAtIndex:i] imageName:[imgs objectAtIndex:i] identifier:[ides objectAtIndex:i] type:i];
//            mo.circledImage=YES;
//            [array addObject:mo];
//        }
//        arrayWithSimpleButtons=array;
    }
    return arrayWithSimpleButtons;
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
            [cell setButtons:[self arrayWithSimpleButtons]];
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

@end
