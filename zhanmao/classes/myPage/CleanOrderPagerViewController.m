//
//  CleanOrderPagerViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CleanOrderPagerViewController.h"
#import "CleanOrderTableViewController.h"

@interface CleanOrderPagerViewController ()<ZZPagerControllerDataSource>

@end

@implementation CleanOrderPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"保洁订单";
    self.dataSource=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return CleanOrderTypeTotalCount;
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    CleanOrderTableViewController* cle=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"CleanOrderTableViewController"];
    cle.type=index;
    return cle;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [CleanOrderModel controllerTitleForType:index];
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
