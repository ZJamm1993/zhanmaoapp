//
//  BaseToolBarTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"

@interface BaseToolBarTableViewController ()
{
    UIButton* submitButton;
}
@end

@implementation BaseToolBarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
    
    self.bottomToolBar=[[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height-self.tableView.contentInset.bottom, self.view.frame.size.width, self.tableView.contentInset.bottom)];
    self.bottomToolBar.backgroundColor=[UIColor whiteColor];
    [self.tableView addSubview:self.bottomToolBar];
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bottomToolBar.frame.size.width, 1/[[UIScreen mainScreen]scale])];
    line.backgroundColor=[UIColor lightGrayColor];
    [self.bottomToolBar addSubview:line];
    
    submitButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.bottomToolBar.frame.size.width-20, self.bottomToolBar.frame.size.height-20)];
    submitButton.backgroundColor=_mainColor;
    [submitButton setTitle:@"立即定制" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [submitButton addTarget:self action:@selector(goToCustom) forControlEvents:UIControlEventTouchUpInside];
    [submitButton.layer setCornerRadius:4];
    [submitButton.layer setMasksToBounds:YES];
    [self.bottomToolBar addSubview:submitButton];
//    [self.tableView insertSubview:self.bottomToolBar atIndex:1000];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

-(void)goToCustom
{
    [self bottomToolBarButtonClicked];
}

-(void)bottomToolBarButtonClicked
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offy=scrollView.contentOffset.y;
    CGFloat h=scrollView.frame.size.height;
    CGFloat b=scrollView.contentInset.bottom;
    CGRect appf=self.bottomToolBar.frame;
    appf.origin.y=offy+h-b;
    self.bottomToolBar.frame=appf;
    
    [self.bottomToolBar removeFromSuperview];
    [self.tableView addSubview:self.bottomToolBar];
}

@end
