//
//  ProductSearchTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ProductSearchTableViewController.h"
#import "SearchTipsView.h"
#import "ZZSearchBar.h"

@interface ProductSearchTableViewController ()<SearchTipsViewDelegate,UITextFieldDelegate>
{
    SearchTipsView* tip;
    ZZSearchBar* searchBar;
}
@end

@implementation ProductSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tip=[SearchTipsView searchTipsViewWithRecentlyStrings:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] trendyString:@[@"1-",@"2-",@"3-",@"4-",@"5-",@"6-"] delegate:self];
    [self.tableView addSubview:tip];
    
    searchBar=[ZZSearchBar defaultBar];
    searchBar.delegate=self;
    self.navigationItem.titleView=searchBar;
    
    UIBarButtonItem* searchBtn=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=searchBtn;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchTipsView:(SearchTipsView *)tipsview selectedString:(NSString *)string
{
    NSLog(@"%@",string);
    searchBar.text=string;
    [self goSearchString:string];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [searchBar resignFirstResponder];
}

-(void)cancel
{
//    [self goSearchString:searchBar.text];
//    [searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self goSearchString:textField.text];
    return NO;
}

-(void)goSearchString:(NSString*)str
{
    
}

@end
