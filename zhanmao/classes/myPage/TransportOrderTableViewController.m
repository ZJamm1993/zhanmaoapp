//
//  TransportOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TransportOrderTableViewController.h"
#import "TransportOrderTableViewCell.h"
#import "TransportOrderDetailTableViewController.h"

@interface TransportOrderTableViewController ()

@end

@implementation TransportOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransportOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"TransportOrderTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TransportOrderDetailTableViewController* tranDetail=[[UIStoryboard storyboardWithName:@"MyOrder" bundle:nil]instantiateViewControllerWithIdentifier:@"TransportOrderDetailTableViewController"];
    [self.navigationController pushViewController:tranDetail animated:YES];
}

@end
