//
//  CustomOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/8.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderTableViewController.h"
#import "CustomOrderTableViewCell.h"

@interface CustomOrderTableViewController ()

@end

@implementation CustomOrderTableViewController

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
    CustomOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CustomOrderTableViewCell" forIndexPath:indexPath];
    
    cell.titleName.text=[CustomOrderModel cellOrderTypeNameForType:self.type];
    cell.idName.text=[CustomOrderModel cellOrderIdNameForType:self.type];
    cell.dateName.text=[CustomOrderModel cellOrderDateNameForType:self.type];
    cell.UnitName.text=[CustomOrderModel cellOrderUnitNameForType:self.type];
    
    cell.canceled=indexPath.section%2==0;
    
    return cell;
}

@end
