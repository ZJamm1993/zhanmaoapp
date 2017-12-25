//
//  TransportOrderPagerViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TransportOrderPagerViewController.h"
#import "TransportOrderTableViewController.h"

@interface TransportOrderPagerViewController ()<ZZPagerControllerDataSource>

@end

@implementation TransportOrderPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource=self;
    self.title=@"物流订单";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return 2;
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    TransportOrderTableViewController* tran=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"TransportOrderTableViewController"];
    tran.type=index+1; //attention
    return tran;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [TransportOrderModel controllerTitleForType:index+1];
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForMenuView:(ZZPagerMenu *)menu
{
    return CGRectMake(0, 0, self.view.frame.size.width, 40);
}

-(CGRect)pagerController:(ZZPagerController *)pager frameForContentView:(UIScrollView *)scrollView
{
    CGRect menuR=[self pagerController:pager frameForMenuView:nil];
    CGFloat menuMy=CGRectGetMaxY(menuR);
    return CGRectMake(0, menuMy, self.view.frame.size.width, self.view.frame.size.height-menuMy-ZZPagerDefaultStatusBarHeight-ZZPagerDefaultNavigationBarHeight);
}

@end
