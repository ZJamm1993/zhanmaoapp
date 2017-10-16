//
//  NaviController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NaviController.h"

@interface NaviController ()<UINavigationControllerDelegate>

@end

@implementation NaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate=self;
    
    self.navigationBar.translucent=NO;
    
    self.navigationBar.tintColor=[UIColor whiteColor];
    
    self.navigationBar.shadowImage=[UIImage imageWithColor:[UIColor groupTableViewBackgroundColor] size:CGSizeMake(self.navigationBar.bounds.size.width, 0.5)];
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:_mainColor size:CGSizeMake(self.navigationBar.bounds.size.width, self.navigationBar.bounds.size.height+20)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    // Do any additional setup after loading the view.
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count!=0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
    
//    UIBarButtonItem* ba=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    viewController.navigationItem.backBarButtonItem=ba;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem* ba=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem=ba;
}

@end
