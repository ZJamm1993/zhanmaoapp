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
    BOOL showingKeyboard;
    CGFloat bottomSafe;
}
@end

@implementation BaseToolBarTableViewController

//-(void)viewSafeAreaInsetsDidChange
//{
//    [super viewSafeAreaInsetsDidChange];
//    if ([self.view respondsToSelector:@selector(safeAreaInsets)]) {
//        if (@available(iOS 11.0, *)) {
//            UIEdgeInsets est=[self.view safeAreaInsets];
//            bottomSafe=est.bottom;
//            
////            self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
//            [self scrollViewDidScroll:self.tableView];
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIToolbar* too=[[UIToolbar alloc]init];;
//    too.frame=CGRectMake(0, 0, 100, 64);
//    [self.tableView addSubview:too];
////    self.navigationController.toolbarHidden=NO;
//    return;
//    self.bottomLayoutGuide;
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
    
    self.bottomToolBar=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.tableView.contentInset.bottom+bottomSafe)];
    self.bottomToolBar.backgroundColor=[UIColor whiteColor];
    [self.tableView addSubview:self.bottomToolBar];
    
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bottomToolBar.frame.size.width, 1/[[UIScreen mainScreen]scale])];
    line.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.bottomToolBar addSubview:line];
    
    UIButton* submitButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.bottomToolBar.frame.size.width-20, self.tableView.contentInset.bottom-20)];
    submitButton.backgroundColor=_mainColor;
    [submitButton setTitle:@"立即定制" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [submitButton addTarget:self action:@selector(goToCustom) forControlEvents:UIControlEventTouchUpInside];
    [submitButton.layer setCornerRadius:4];
    [submitButton.layer setMasksToBounds:YES];
    [self.bottomToolBar insertSubview:submitButton atIndex:0];
    
    self.bottomButton=submitButton;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHides:) name:UIKeyboardDidHideNotification object:nil];
    
    
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
}

-(void)keyboardShows:(NSNotification*)noti
{
    //    NSLog(@"%@",noti);
    
    //UIKeyboardFrameEndUserInfoKey;
    //UIKeyboardAnimationDurationUserInfoKey;
    //UIKeyboardAnimationCurveUserInfoKey;
    
    showingKeyboard=YES;
}

-(void)keyboardHides:(NSNotification*)noti
{
    //    NSLog(@"%@",noti);
    
    showingKeyboard=NO;
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
    if (showingKeyboard) {
        return;
    }
    CGFloat offy=scrollView.contentOffset.y;
    CGFloat h=scrollView.frame.size.height;
    CGFloat b=scrollView.contentInset.bottom;
    
    CGRect appf=self.bottomToolBar.frame;
    appf.origin.y=offy+h-b-bottomSafe;
//    appf.size.height=b+bottomSafe;
    self.bottomToolBar.frame=appf;
    
    [self.bottomToolBar removeFromSuperview];
    [self.tableView addSubview:self.bottomToolBar];
}

-(CGRect)bottomViewFrame
{
    return CGRectMake(10, 10, self.bottomToolBar.frame.size.width, self.tableView.contentInset.bottom-20);
}

@end
