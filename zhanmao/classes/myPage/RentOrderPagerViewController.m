//
//  RentOrderPagerViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderPagerViewController.h"
#import "RentOrderTableViewController.h"

@interface RentOrderPagerViewController ()<ZZPagerControllerDataSource>

@end

@implementation RentOrderPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"租赁订单";
    self.dataSource=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numbersOfChildControllersInPagerController:(ZZPagerController *)pager
{
    return RentOrderTypeTotalCount;
}

-(UIViewController*)pagerController:(ZZPagerController *)pager viewControllerAtIndex:(NSInteger)index
{
    RentOrderTableViewController* rent=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"RentOrderTableViewController"];
    rent.type=index;
    return rent;
}

-(NSString*)pagerController:(ZZPagerController *)pager titleAtIndex:(NSInteger)index
{
    return [RentOrderModel controllerTitleForType:index];
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
