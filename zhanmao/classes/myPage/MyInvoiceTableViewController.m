//
//  MyInvoiceTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyInvoiceTableViewController.h"
#import "MyInvoiceTableViewCell.h"

@interface MyInvoiceTableViewController ()

@end

@implementation MyInvoiceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==tableView.numberOfSections-1) {
        return 100;
    }
    return 0.0001;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInvoiceTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyInvoiceTableViewCell" forIndexPath:indexPath];
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section==tableView.numberOfSections-1) {
        return @"温馨提示：\n电子发票可以查询最近6个月（包括本月）的记录。\n\n";
    }
    return nil;
}

@end
