//
//  CleanOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CleanOrderTableViewController.h"
#import "CleanOrderTableViewCell.h"

@interface CleanOrderTableViewController ()

@end

@implementation CleanOrderTableViewController

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
    CleanOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CleanOrderTableViewCell" forIndexPath:indexPath];
    return cell;
}

@end
