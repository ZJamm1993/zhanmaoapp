//
//  MyPageTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageTableViewController.h"
#import "MyPageHeaderTableViewCell.h"
#import "MyPageSimpleTableViewCell.h"
#import "MyLoginViewController.h"
#import "MyPageCellModel.h"
#import "MyPageHttpTool.h"

#import "BaseWebViewController.h"

//typedef NS_ENUM(NSInteger, MyPageSection) {
//    
//    MyPageSectionHeaders,
//    MyPageSectionPersonals,
//    MyPageSectionInvoices,
//    MyPageSectionHelps,
//    
//    MyPageSectionTotalCount,
//};
//


@interface MyPageTableViewController ()<SimpleButtonsTableViewCellDelegate,MyPageHeaderTableViewCellDelegate>
{
    NSArray* arrayWithSimpleButtons;
    NSArray* cellModelsArray;
    
    NSMutableDictionary* cachesControllers;
    
    UserModel* myUser;
    BOOL askedToPerfectInfo;
    
    NSString* consumer_phone;
}
@end

@implementation MyPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.title=@"我的";
    self.refreshControl.tintColor=[UIColor whiteColor];
//    [self.refreshControl removeFromSuperview];
    
    cachesControllers=[NSMutableDictionary dictionary];
    
//    self.tableView.contentInset=UIEdgeInsetsMake([[UIApplication sharedApplication]statusBarFrame].size.height,0, 0, 0);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageSimpleTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPageSimpleTableViewCell"];
    
    [self refreshCellsModel];
    [self refresh];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoDidUpdateNotification:) name:UserInfoDidUpdateNotification object:nil];
//    [self.tableView setContentOffset:CGPointMake(0, -self.tableView.contentInset.top)];
    // Do any additional setup after loading the view.
}

#pragma mark navbar and statusbar

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self performSelector:@selector(updateUserInfo) withObject:nil afterDelay:0.1];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark datas

-(void)refreshCellsModel
{
    cellModelsArray=[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"" image:@"" detail:@"" identifier:@""], nil],
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"地址管理" image:@"myAddress" detail:@"" identifier:@"MyAddressesTableViewController"],
                      [MyPageCellModel modelWithTitle:@"个人资料" image:@"myInfo" detail:@"" identifier:@"MyPersonalInfoViewController"], nil],
                     //            [NSArray arrayWithObjects:
                     //             [MyPageCellModel modelWithTitle:@"申请发票" image:@"myInvoice" detail:@"" identifier:@"MyInvoicePagerViewController"],nil],
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"帮助中心" image:@"myHelp" detail:@"" identifier:@"MyHelpCenterTableViewController"],
                      [MyPageCellModel modelWithTitle:@"意见反馈" image:@"myAdvice" detail:@"" identifier:@"MyFeedBackTableViewController"],
                      [MyPageCellModel modelWithTitle:@"租赁协议" image:@"myProtocal" detail:@"" identifier:@"pro"],
                      [MyPageCellModel modelWithTitle:@"客服电话" image:@"myService" detail:consumer_phone identifier:@"tel"], nil],
                     nil];
}

-(void)updateUserInfo
{
    if ([UserModel token].length>0) {
        myUser=[UserModel getUser];
        if ([myUser isNullUser])
        {
            [self performSelector:@selector(refresh) withObject:nil afterDelay:0.01];
        }
        else
        {
            [self.tableView reloadData];
        }
    }
    else
    {
        myUser=nil;
        [self.tableView reloadData];
    }
}

-(void)refresh
{
    if ([UserModel token].length>0) {
        [MyPageHttpTool getPersonalInfoToken:[UserModel token] success:^(UserModel *user,NSInteger code) {
            
            if (code==ZZHttpCodeTokenInvalid) {
                [MBProgressHUD showErrorMessage:@"登录信息已过期"];
                [UserModel saveToken:@""];
                [UserModel deleteUser];
            }
            else
            {
                [UserModel saveUser:user];
                myUser=[UserModel getUser];
            }
            [self.tableView reloadData];
        }];
    }
    else
    {
        [self.refreshControl endRefreshing];
    }
    
    [MyPageHttpTool getStandardConfigCache:NO success:^(NSDictionary *config) {
        if (config) {
            consumer_phone=[config valueForKey:@"consumer_phone"];
            [self refreshCellsModel];
            [self.tableView reloadData];
        }
    }];
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
//            mo.circledImage=YES;
            [array addObject:mo];
        }
        arrayWithSimpleButtons=array;
    }
    return arrayWithSimpleButtons;
}

#pragma mark tableView delegate & datasource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section<=1) {
//        return 0.0001;
//    }
//    return 10;
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.0001;
    }
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return cellModelsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section==0) {
//        return 1;
//    }
//    else
//    {
        NSArray* arr=[cellModelsArray objectAtIndex:section];
        return arr.count;
//    }
//    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==0) {
        MyPageHeaderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageHeaderTableViewCell" forIndexPath:indexPath];
        [cell setButtons:[self arrayWithSimpleButtons]];
        [cell setDelegate:self];
        [cell setSimpleButtonsCellDelegate:self];
        cell.headImageView.image=[UIImage imageNamed:@"defaultHeadImage"];
        cell.name.text=@"请登录";
        cell.loginBg.hidden=YES;
        
        if ([UserModel token].length>0) {
            cell.loginBg.hidden=NO;
            [cell.headImageView sd_setImageWithURL:[myUser.avatar urlWithMainUrl] placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
            [cell.loginBgImage sd_setImageWithURL:[myUser.avatar urlWithMainUrl] placeholderImage:nil];
            [cell.loginBgBlurImage sd_setImageWithURL:[myUser.avatar urlWithMainUrl] placeholderImage:nil];
            cell.name.text=myUser.user_nicename;
//            if (myUser.user_nicename.length==0) {
//                cell.name.text=
//            }
        }
        return cell;
    }
    else
    {
        NSArray* arr=[cellModelsArray objectAtIndex:sec];
        MyPageCellModel* mo=[arr objectAtIndex:row];
        
        MyPageSimpleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageSimpleTableViewCell" forIndexPath:indexPath];
        cell.textLabel.text=mo.title;
        cell.imageView.image=[UIImage imageNamed:mo.image];
        cell.detailTextLabel.text=mo.detail;
        
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray* arr=[cellModelsArray objectAtIndex:indexPath.section];
    MyPageCellModel* mo=[arr objectAtIndex:indexPath.row];
    NSLog(@"%@",mo.identifier);
    
    //specials
    //specials
    if ([mo.identifier isEqualToString:@"tel"]) {
        NSString* str=[NSString stringWithFormat:@"tel://%@",mo.detail];
        NSURL* phone=[NSURL URLWithString:str];
        if ([[UIApplication sharedApplication]canOpenURL:phone] ) {
            [[UIApplication sharedApplication]openURL:phone];
        }
        else{
            [MBProgressHUD showErrorMessage:@"设备不支持拨打电话"];
        }
        return;
    }
    else if([mo.identifier isEqualToString:@"pro"])
    {
        BaseWebViewController* proto=[[BaseWebViewController alloc]initWithUrl:[HTML_BugProtocol urlWithMainUrl]];
        proto.title=@"租赁协议";
        [self.navigationController pushViewController:proto animated:YES];
        return;
    }
    
    //normals
    else
    {
        BOOL shouldCheckToken=(indexPath.section!=([tableView numberOfSections]-1));
        [self pushToViewControllerId:mo.identifier checkToken:shouldCheckToken];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [super scrollViewDidScroll:scrollView];
    
    if (scrollView==self.tableView) {
        CGFloat offY=scrollView.contentOffset.y;
        
        NSArray* cells=[self.tableView visibleCells];
        for (UITableViewCell* cell in cells) {
            if ([cell isKindOfClass:[MyPageHeaderTableViewCell class]]) {
                MyPageHeaderTableViewCell* headerCell=(MyPageHeaderTableViewCell*)cell;
                
                CGFloat topCon=offY;
                if (topCon>0) {
                    topCon=0;
                }
                headerCell.loginBgTopContraint.constant=topCon;
                
                CGFloat fa=64;
                CGFloat blurAlpha=(fa+offY)/fa;
                if (blurAlpha>1) {
                    blurAlpha=1;
                }
                if (blurAlpha<0) {
                    blurAlpha=0;
                }
                headerCell.loginBgImage.alpha=blurAlpha;
                
            }
        }
    }
}

#pragma mark SimpleButtonsTableViewCellDelegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    if ([UserModel token].length==0) {
        [self askToLogin];
        return;
    }
    NSLog(@"%@",model.title);
//    [self pushToViewControllerId:model.identifier];
    if (model.identifier.length>0) {
        Class pagerClass=NSClassFromString(model.identifier);
        if (pagerClass) {
            UIViewController* vc=[[pagerClass alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma headerCellDelegate

-(void)myPageHeaderTableViewCellSettingButtonClicked:(MyPageHeaderTableViewCell *)cell
{
//    [self pushToViewControllerId:@"MySettingTableViewController"];
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MySettingTableViewController"] animated:YES];
}

-(void)myPageHeaderTableViewCellPersonalButtonClicked:(MyPageHeaderTableViewCell *)cell
{
    if ([UserModel token].length==0) {
        [self goToLogin];
    }
    else
    {
        [self pushToViewControllerId:@"MyPersonalInfoViewController" checkToken:NO];
    }
}

#pragma mark actions

-(void)pushToViewControllerId:(NSString*)identifier checkToken:(BOOL)checkToken
{
    //normals
    if ([UserModel token].length==0&&checkToken) {
        [self askToLogin];
        return;
    }
    if (identifier.length>0) {
        //        UIViewController* viewController;//=[cachesControllers valueForKey:identifier];
        //        if (viewController==nil) {
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"MyPage" bundle:nil];
        NSLog(@"%@",sb);
        UIViewController* viewController=[sb instantiateViewControllerWithIdentifier:identifier];
        //            [cachesControllers setValue:viewController forKey:identifier];
        //        }
        
        [self.navigationController pushViewController:viewController animated:YES];
        //        if ([identifier isEqualToString:@"MyPersonalInfoViewController"]) {
        //            askedToPerfectInfo=YES;
        //        }
    }
}

-(void)askToLogin
{
    [MBProgressHUD showErrorMessage:AskToLoginDescription];
    [self goToLogin];
    return;
}

-(void)goToLogin
{
    [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
}

@end
