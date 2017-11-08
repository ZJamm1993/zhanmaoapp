//
//  MyAddressEditTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyAddressesTableViewController.h"
#import "AddressListTableViewCell.h"
#import "AddressOptionTableViewCell.h"

@interface MyAddressesTableViewController ()

@end

@implementation MyAddressesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收货地址";
    [self.bottomButton setTitle:@"新增地址" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    
    for (int i=0; i<4; i++) {
        [self.dataSource addObject:[[AddressModel alloc]init]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2; //static
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        AddressListTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddressListTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    else if(indexPath.row==1)
    {
        AddressOptionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddressOptionTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        //do some
        AddressModel* model=[self.dataSource objectAtIndex:indexPath.section];
        if ([self.delegate respondsToSelector:@selector(myAddressesTableViewController:didSelectedAddress:)]) {
            [self.delegate myAddressesTableViewController:self didSelectedAddress:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
