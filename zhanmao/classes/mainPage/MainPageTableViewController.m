//
//  MainPageTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MainPageTableViewController.h"
#import "SimpleButtonsTableViewCell.h"
#import "ExhibitionLargeTableViewCell.h"

typedef NS_ENUM(NSInteger,MainPageSection)
{
    MainPageSectionEights,
    MainPageSectionExhibition,
    MainPageSectionTotalCount,
};

@interface MainPageTableViewController ()
{
    UIBarButtonItem* locationItem;
    NSArray* arrayWithSimpleButtons;
}
@end

@implementation MainPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"展贸在线";
    self.tabBarItem.title=@"主页";
    
    locationItem=[[UIBarButtonItem alloc]initWithTitle:@"广州" style:UIBarButtonItemStylePlain target:self action:@selector(selectLocation)];
    UIBarButtonItem* downInd=[[UIBarButtonItem alloc]initWithTitle:@"⌄" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:locationItem, downInd, nil];
    
    [self setAdvertiseHeaderViewWithPicturesUrls:[NSArray arrayWithObjects:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1508124415&di=5db22a966bc422bbb5ff5d141c72a784&src=http://img0.pconline.com.cn/pconline/1612/22/8693800_tupian9_fuben_thumb.png", @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2458910651,1579540110&fm=27&gp=0.jpg", nil]];
    
    [self.tableView registerClass:[SimpleButtonsTableViewCell class] forCellReuseIdentifier:@"SimpleButtonsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExhibitionLargeTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExhibitionLargeTableViewCell"];
}

-(NSArray*)arrayWithSimpleButtons
{
    if (arrayWithSimpleButtons.count==0) {
        
        NSMutableArray* array=[NSMutableArray array];
        NSArray* titles=[NSArray arrayWithObjects:@"主场",@"展台",@"展厅",@"演艺",@"舞台",@"会议",@"保洁",@"物流",@"",@"", nil];
        
        for (NSInteger i=0; i<8; i++) {
            SimpleButtonModel* mo=[[SimpleButtonModel alloc]initWithTitle:[titles objectAtIndex:i] imageName:@"a" identifier:[NSString stringWithFormat:@"%ld",(long)i]];
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
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MainPageSectionTotalCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==MainPageSectionEights) {
        return 1;
    }
    else if(section==MainPageSectionExhibition)
    {
        return 3;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    if (sec==MainPageSectionEights) {
        return [SimpleButtonsTableViewCell heightWithButtonsCount:[self arrayWithSimpleButtons].count];
    }
    return UITableViewAutomaticDimension;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    
    if(sec==MainPageSectionEights)
    {
        SimpleButtonsTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SimpleButtonsTableViewCell" forIndexPath:indexPath];
        cell.buttons=[self arrayWithSimpleButtons];
        return cell;
    }
    else if(sec==MainPageSectionExhibition)
    {
        ExhibitionLargeTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

@end
