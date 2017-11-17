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

typedef NS_ENUM(NSInteger,TravellingSection)
{
    TravellingSectionHeaders,
    TravellingSectionTotalCount,
};


@interface TravellingRootViewController ()<SimpleButtonsTableViewCellDelegate>
{
    NSArray* arrayWithSimpleButtons;
}
@end

@implementation TravellingRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商旅";
    
    [self setAdvertiseHeaderViewWithPicturesUrls:[NSArray arrayWithObjects:
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508838600421&di=657bb23fe8427c3b0bd101fe297214d2&imgtype=0&src=http%3A%2F%2Fwww.im4s.cn%2Ftrade%2Fuploads%2Fallimg%2F160606%2F456-160606114A6326.jpg",
                        @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1889566272,4112726323&fm=27&gp=0.jpg",
                        @"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil]];
    // Do any additional setup after loading the view.
    
    //test
    for (int i=0; i<3; i++) {
        [self.dataSource addObject:[[NSObject alloc]init]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)arrayWithSimpleButtons
{
    if (arrayWithSimpleButtons.count==0) {
        
        NSMutableArray* array=[NSMutableArray array];
        NSArray* tits=[NSArray arrayWithObjects:@"租赁订单",@"物流订单",@"保洁订单",@"定制订单", nil];
        NSArray* imgs=[NSArray arrayWithObjects:@"orderRent",@"orderTransport",@"orderClean",@"orderCustom", nil];
        NSArray* ides=[NSArray arrayWithObjects:@"RentOrderPagerViewController",@"TransportOrderPagerViewController",@"CleanOrderPagerViewController",@"CustomOrderPagerViewController", nil];
        
        for (NSInteger i=0; i<4; i++) {
            SimpleButtonModel* mo=[[SimpleButtonModel alloc]initWithTitle:[tits objectAtIndex:i] imageName:[imgs objectAtIndex:i] identifier:[ides objectAtIndex:i] type:i];
            mo.circledImage=YES;
            [array addObject:mo];
        }
        arrayWithSimpleButtons=array;
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
        NSObject* obj=[self.dataSource objectAtIndex:sec];
        cell.title.text=obj.description;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

@end
