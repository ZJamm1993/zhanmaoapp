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
#import "MainPageHeaderTableViewCell.h"
#import "MessageSmallTableViewCell.h"

#import "BaseFormTableViewController.h"
#import "ExhibitionListViewController.h"
#import "NaviController.h"

#import "ImageTitleBarButtonItem.h"

#import <CoreLocation/CoreLocation.h>

#import "MainPageHttpTool.h"

#import "ProductWebDetailViewController.h"
#import "ExhibitionDetailViewController.h"

#import "MyLoginViewController.h"

typedef NS_ENUM(NSInteger,MainPageSection)
{
    MainPageSectionEights,
    MainPageSectionExhibitions,
    MainPageSectionGoodsPushes,
    MainPageSectionNewMsgs,
    MainPageSectionTotalCount,
};

@interface MainPageTableViewController ()<SimpleButtonsTableViewCellDelegate,CLLocationManagerDelegate>
{
//    UIBarButtonItem* locationItem;
    NSArray* arrayWithSimpleButtons;
    
    NSMutableArray* exhibitionArray;
    NSMutableArray* goodpushesArray;
    NSMutableArray* messagesArray;
    
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
    BOOL locatedCity;
}
@end

@implementation MainPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl.tintColor=[UIColor whiteColor];
    self.navigationItem.title=@"展贸在线";
    self.tabBarItem.title=@"主页";
    
    [self setLocation:@"广州"];
    
//    self.tableView.contentInset=UIEdgeInsetsMake(-20, 0, 0, 0);
    
    UIBarButtonItem* searchItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searchWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    self.navigationItem.rightBarButtonItem=searchItem;
    
    [self showLoadMoreView];
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MainPageHeaderTableViewCell"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"SimpleHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"SimpleHeaderTableViewCell"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"ExhibitionLargeCardTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExhibitionLargeCardTableViewCell"];
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"MessageSmallTableViewCell" bundle:nil] forCellReuseIdentifier:@"MessageSmallTableViewCell"];
    
//    messagesArray=[NSMutableArray array];
//    for (int i=0; i<10; i++) {
//        [messagesArray addObject:@"a"];
//    }
    
    [self refresh];
    
//    [self locate];
//    self.tableView.sectionHeaderHeight=44;
    
//    self.toolbarItems=[NSArray arrayWithObject:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil]];
//    self.navigationController.toolbarHidden=NO;
}

- (void)locate {
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager startUpdatingLocation];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [((NaviController*)self.navigationController) setNavigationColorShowImage:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [((NaviController*)self.navigationController) setNavigationColorShowImage:YES];
}

#pragma mark cllocationdelegate

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [locationManager stopUpdatingLocation];
    if (locatedCity) {
        return;
    }
    locatedCity=YES;
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"未知";
            }
            NSLog(@"%@",currentCity); //这就是当前的城市
            NSLog(@"%@",placeMark.name);//具体地址:  xx市xx区xx街道
//            [MBProgressHUD showErrorMessage:[NSString stringWithFormat:@"已定位到:%@",currentCity]];
            [self setLocation:currentCity];
        }
        else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
        }
        else if (error) {
            NSLog(@"location error: %@ ",error);
        }
        
    }];
}

#pragma mark datas

-(void)refresh
{
    [MainPageHttpTool getNewExhibitions:^(NSArray *exhs) {
        exhibitionArray=[NSMutableArray arrayWithArray:exhs];
        [self.tableView reloadData];
    } cache:NO failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    [MainPageHttpTool getNewMessagesPage:1 pageSize:self.pageSize cached:NO success:^(NSArray *result) {
        messagesArray=[NSMutableArray arrayWithArray:result];
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
    [MainPageHttpTool getNewMessagesPage:self.currentPage+1 pageSize:self.pageSize cached:NO success:^(NSArray *result) {
        if (messagesArray==nil) {
            messagesArray=[NSMutableArray array];
        }
        [messagesArray addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

-(NSArray*)arrayWithSimpleButtons
{
    if (arrayWithSimpleButtons.count==0) {
        
        NSMutableArray* array=[NSMutableArray array];
        for (NSInteger i=0; i<8; i++) {
            NSNumber* num=[NSNumber numberWithInteger:i];
            [array addObject:num];
        }
        arrayWithSimpleButtons=[SimpleButtonModel exampleButtonModelsWithTypes:array];;
    }
    return arrayWithSimpleButtons;
}

#pragma mark actions

-(void)setLocation:(NSString*)location
{
    ImageTitleBarButtonItem* it=[ImageTitleBarButtonItem itemWithImageName:@"locationWhite" leftImage:YES title:location target:self selector:@selector(selectLocation)];
    self.navigationItem.leftBarButtonItem=it;
}

-(void)goSearch
{
//    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductSearchTableViewController"] animated:YES];
    UIViewController* sear=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductSearchTableViewController"];
    UINavigationController* nav=[[NaviController alloc]initWithRootViewController:sear];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)selectLocation
{
    NSLog(@"select location");
//    [self setLocation:[NSString stringWithFormat:@"%ld",(long)(arc4random()%1000000)]];
    
//    [locationManager startUpdatingLocation];
//    locatedCity=NO;
    
}

#pragma mark UITableViewDelegate&Datasource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section<=MainPageSectionExhibitions) {
        return 12;
    }
    return 0.0001;
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
    else if(section==MainPageSectionExhibitions)
    {
        return exhibitionArray.count;
    }
    else if(section==MainPageSectionGoodsPushes)
    {
        return goodpushesArray.count;
    }
    else if(section==MainPageSectionNewMsgs)
    {
        return messagesArray.count;
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
    
    if(sec==MainPageSectionEights)
    {
        MainPageHeaderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MainPageHeaderTableViewCell" forIndexPath:indexPath];
        [cell setButtons:[self arrayWithSimpleButtons]];
        [cell setDelegate:self];
        return cell;
    }
    else
    {
        if(sec==MainPageSectionExhibitions)
        {
            ExhibitionLargeCardTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeCardTableViewCell" forIndexPath:indexPath];
            ExhibitionModel* mo=[exhibitionArray objectAtIndex:row];
            cell.label.text=mo.exhibition_name;
            [cell.image sd_setImageWithURL:[mo.thumb urlWithMainUrl]];
            return cell;
        }
        else if(sec==MainPageSectionGoodsPushes)
        {
            // there is no goods pushed any more;
        }
        else if(sec==MainPageSectionNewMsgs)
        {
            MessageSmallTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MessageSmallTableViewCell" forIndexPath:indexPath];

            MainMsgModel* msg=[messagesArray objectAtIndex:row];
            cell.showImage=msg.show_type==MainMsgShowTypeImageText;
            cell.showReadCount=msg.model_type==MainMsgModelTypeNews;
            if (cell.showReadCount) {
                cell.headerImage.image=[UIImage imageNamed:@"newMessage"];
                cell.headerTitle.text=@"最新消息";
            }
            else
            {
                cell.headerImage.image=[UIImage imageNamed:@"newProduct"];
                cell.headerTitle.text=@"新品推送";
            }
            cell.title.text=msg.post_title;
            cell.content.text=msg.post_excerpt;
            cell.time.text=msg.post_modified;
            cell.readCount.text=[NSString stringWithFormat:@"%ld",(long)msg.post_hits];
            [cell.image sd_setImageWithURL:[msg.thumb urlWithMainUrl]];
            return cell;
        }
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if(sec==MainPageSectionNewMsgs)
    {
        MainMsgModel* msg=[messagesArray objectAtIndex:row];
        if (msg.model_type==MainMsgModelTypeProduct) {
            RentProductModel* pro=[[RentProductModel alloc]init];
            pro.idd=msg.idd;
            ProductWebDetailViewController* prod=[[ProductWebDetailViewController alloc]init];
            prod.goodModel=pro;
            [self.navigationController pushViewController:prod animated:YES];
        }
        else
        {
            BaseWebViewController* web=[[BaseWebViewController alloc]initWithUrl:[HTML_NewsDetail urlWithMainUrl]];
            web.idd=msg.idd.integerValue;
            [self.navigationController pushViewController:web animated:YES];
        }
    }
    if (sec==MainPageSectionExhibitions) {
        ExhibitionModel* mo=[exhibitionArray objectAtIndex:row];
        ExhibitionDetailViewController* exh=[[ExhibitionDetailViewController alloc]init];
        exh.exhi=mo;
        [self.navigationController pushViewController:exh animated:YES];
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if(section==0)
//    {
//        return 0.01;
//    }
//    return 44;
//}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell isKindOfClass:[ExhibitionLargeCardTableViewCell class]]) {
//        [((ExhibitionLargeCardTableViewCell*)cell) setCornerRadius];
//    }
//}

#pragma mark SimpleButtonsTableViewCellDelegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    NSLog(@"%@",model.title);
    if (model.identifier.length>0) {
//        if(model.type<=6)
//        {
//            if ([UserModel token].length==0) {
//                [MBProgressHUD showErrorMessage:AskToLoginDescription];
//                [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
//                return;
//            }
//        }
        Class cla=NSClassFromString(model.identifier);
        BaseFormTableViewController* form=[[cla alloc]init];
        if ([form isKindOfClass:[BaseFormTableViewController class]]) {
            
            [self.navigationController pushViewController:form animated:YES];
            return;
        }
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"MainPage" bundle:nil];
            
        ExhibitionListViewController* viewController=[sb instantiateViewControllerWithIdentifier:model.identifier];
        if([viewController isKindOfClass:[ExhibitionListViewController class]])
        {
            viewController.type=model.type;
            viewController.title=[NSString stringWithFormat:@"%@案例",model.title];
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
