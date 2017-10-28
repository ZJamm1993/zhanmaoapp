//
//  ProductSearchTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ProductSearchTableViewController.h"
#import "SearchTipsView.h"

@interface ProductSearchTableViewController ()<SearchTipsViewDelegate>

@end

@implementation ProductSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchTipsView* tip=[SearchTipsView searchTipsViewWithRecentlyStrings:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"] trendyString:@[@"1-",@"2-",@"3-",@"4-",@"5-",@"6-"] delegate:self];
    [self.tableView addSubview:tip];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
