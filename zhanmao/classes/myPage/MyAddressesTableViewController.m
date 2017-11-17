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
    
    //test
    for (int i=0; i<4; i++) {
        AddressModel* add=[[AddressModel alloc]init];
        add.idd=[NSString stringWithFormat:@"addressid%d",i];
        add.addressee=[NSString stringWithFormat:@"xiao%dming",i];
        int k=i;
        add.phone=[NSString stringWithFormat:@"%d%d%d%d%d%d%d%d%d%d",i,k++,k++,k++,k++,k++,k++,k++,k++,k++];
        add.address=[NSString stringWithFormat:@"guang%dzhouguang%dzhouguang%dzhouguang%dzhou",i,i,i,i];
        [self.dataSource addObject:add];
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
    AddressModel* add=[self.dataSource objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
        AddressListTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddressListTableViewCell" forIndexPath:indexPath];
        cell.name.text=add.addressee;
        cell.phone.text=add.phone;
        cell.address.text=add.address;
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
