//
//  MainPageTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MainPageTableViewController.h"

#import "SimpleButtonsTableViewCell.h"
#import "ExhibitionLargeCardTableViewCell.h"
#import "SimpleHeaderTableViewCell.h"
#import "MainPageHeaderTableViewCell.h"
#import "MessageSmallTableViewCell.h"

#import "ImageTitleBarButtonItem.h"

typedef NS_ENUM(NSInteger,MainPageSection)
{
    MainPageSectionEights,
    MainPageSectionExhibitions,
    
    MainPageSectionTotalCount,
};

@interface MainPageTableViewController ()<SimpleButtonsTableViewCellDelegate>
{
//    UIBarButtonItem* locationItem;
    NSArray* arrayWithSimpleButtons;
    NSMutableArray* messagesArray;
}
@end

@implementation MainPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"展贸在线";
    self.tabBarItem.title=@"主页";
    
//    [self setLocation:@"guangz"];
    
    self.tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0);
    
    UIBarButtonItem* searchItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searchWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    self.navigationItem.rightBarButtonItem=searchItem;
    
//    locationItem.image=[UIImage imageNamed:@"a.png"];
//    UIBarButtonItem* downInd=[[UIBarButtonItem alloc]initWithTitle:@"V" style:UIBarButtonItemStylePlain target:nil action:nil];
    
//    self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:locationItem, nil];
    
//    [self setAdvertiseHeaderViewWithPicturesUrls:[NSArray arrayWithObjects:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1508124415&di=5db22a966bc422bbb5ff5d141c72a784&src=http://img0.pconline.com.cn/pconline/1612/22/8693800_tupian9_fuben_thumb.png", @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2458910651,1579540110&fm=27&gp=0.jpg", nil]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainPageHeaderTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"SimpleHeaderTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ExhibitionLargeCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExhibitionLargeCardTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageSmallTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageSmallTableViewCell"];
    
    messagesArray=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        [messagesArray addObject:@"a"];
    }
//    self.tableView.sectionHeaderHeight=44;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)setLocation:(NSString*)location
{
    ImageTitleBarButtonItem* it=[ImageTitleBarButtonItem itemWithImageName:@"locationWhite" title:location target:self selector:@selector(selectLocation)];
    self.navigationItem.leftBarButtonItem=it;
}

-(void)goSearch
{
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductSearchTableViewController"] animated:YES];
}

-(NSArray*)arrayWithSimpleButtons
{
    if (arrayWithSimpleButtons.count==0) {
        
        NSMutableArray* array=[NSMutableArray array];
        NSArray* titles=[NSArray arrayWithObjects:@"主场",@"展台",@"展厅",@"舞台",@"演艺",@"会议",@"保洁",@"物流",@"",@"", nil];
        NSArray* images=[NSArray arrayWithObjects:@"zhuchang",@"zhantai",@"zhanting",@"wutai",@"yanyi",@"huiyi",@"baojie",@"wuliu",@"",@"", nil];
        NSArray* identis=[NSArray arrayWithObjects:@"ExhibitionListViewController", nil];
        for (NSInteger i=0; i<8; i++) {
            SimpleButtonModel* mo=[[SimpleButtonModel alloc]initWithTitle:[titles objectAtIndex:i] imageName:[images objectAtIndex:i] identifier:i<identis.count?[identis objectAtIndex:i]:@""];
            [array addObject:mo];
        }
        arrayWithSimpleButtons=array;
    }
    return arrayWithSimpleButtons;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectLocation
{
    NSLog(@"select location");
    [self setLocation:[NSString stringWithFormat:@"%ld",(long)(arc4random()%1000000)]];
}

#pragma mark UITableViewDelegate&Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MainPageSectionTotalCount+messagesArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==MainPageSectionEights) {
        return 1;
    }
    else if(section==MainPageSectionExhibitions)
    {
        return 2;
    }
    else
    {
        return 2;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger sec=indexPath.section;
//    if (sec==MainPageSectionEights) {
//        return [SimpleButtonsTableViewCell heightWithButtonsCount:[self arrayWithSimpleButtons].count];
//    }
    return UITableViewAutomaticDimension;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    NSInteger msgSection=sec-(tableView.numberOfSections-messagesArray.count);
    
    if(sec==MainPageSectionEights)
    {
        MainPageHeaderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MainPageHeaderTableViewCell" forIndexPath:indexPath];
        [cell setButtons:[self arrayWithSimpleButtons]];
        [cell setDelegate:self];
        return cell;
    }
    else
    {
        if (row==0) {
            SimpleHeaderTableViewCell* sim=[tableView dequeueReusableCellWithIdentifier:@"SimpleHeaderTableViewCell" forIndexPath:indexPath];
            if (sec==0) {
                //....
            }
            else if(sec==1)
            {
                //....
            }
            return sim;
        }
        else if(sec==MainPageSectionExhibitions)
        {
            
            ExhibitionLargeCardTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeCardTableViewCell" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            MessageSmallTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MessageSmallTableViewCell" forIndexPath:indexPath];
            cell.showImage=(msgSection%3==0);
            cell.showReadCount=(msgSection%2==0);
            return cell;
        }
    }
    
    return [[UITableViewCell alloc]init];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(section==0)
//    {
//        return 0.01;
//    }
//    return 44;
//}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[ExhibitionLargeCardTableViewCell class]]) {
        [((ExhibitionLargeCardTableViewCell*)cell) setCornerRadius];
    }
}

#pragma mark SimpleButtonsTableViewCellDelegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    NSLog(@"%@",model.title);
    if (model.identifier.length>0) {
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"MainPage" bundle:nil];
        
        UIViewController* viewController=[sb instantiateViewControllerWithIdentifier:model.identifier];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
