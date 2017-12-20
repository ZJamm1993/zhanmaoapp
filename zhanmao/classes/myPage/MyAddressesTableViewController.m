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
#import "AddressAddNewFormTableViewController.h"
#import "MyLoginViewController.h"
#import "MyPageHttpTool.h"

@interface MyAddressesTableViewController ()<AddressOptionTableViewCellDelegate>

@end

@implementation MyAddressesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收货地址";
    [self.bottomButton setTitle:@"新增地址" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    
//    [self.refreshControl beginRefreshing];
    [self refresh];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addressDidAddNewNotification:) name:AddressAddNewNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    NSString* token=[UserModel token];
    
    if (token.length>0) {
        [MyPageHttpTool getMyAddressesToken:token cache:NO success:^(NSArray *result) {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:result];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self.tableView reloadData];
        }];
    }
    else
    {
        [MBProgressHUD showErrorMessage:AskToLoginDescription];
        [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
    }
}

#pragma mark notifications

-(void)addressDidAddNewNotification:(NSNotification*)notification
{
    NSDictionary* usr=notification.userInfo;
    AddressModel* added=[[AddressModel alloc]initWithDictionary:usr];
    
    NSMutableArray* addToDelete=[NSMutableArray array];;
    for (AddressModel* mo in self.dataSource) {
        if ([mo.idd isEqualToString:added.idd]) {
            [addToDelete addObject:mo];
        }
        if (added.classic) {
            mo.classic=NO;
        }
    }
    [self.dataSource removeObjectsInArray:addToDelete];
    [self.dataSource insertObject:added atIndex:0];
    
    [self.tableView reloadData];
}

#pragma mark tableviews

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
        NSString* pro=add.province;
        NSString* cit=add.city;
        NSString* dis=add.district;
        NSString* adr=add.address;
        if (pro.length==0) {
            pro=@"";
        }
        if (cit.length==0) {
            cit=@"";
        }
        if (dis.length==0) {
            dis=@"";
        }
        if (adr.length==0) {
            adr=@"";
        }
        cell.address.text=[NSString stringWithFormat:@"%@%@%@%@",pro,cit,dis,adr];
        return cell;
    }
    else if(indexPath.row==1)
    {
        AddressOptionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddressOptionTableViewCell" forIndexPath:indexPath];
        cell.defaulButton.selected=add.classic;
        cell.delegate=self;
//        cell.tag=indexPath.row;
        cell.model=add;
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

#pragma mark addressotiontableviewcell delegate& actions

-(void)addressOtionTableViewCell:(AddressOptionTableViewCell *)cell doAction:(AddressOptionAction)action
{
    NSString* token=[UserModel token];
    
    AddressModel* model=cell.model;
    NSLog(@"%@,%@",model.idd,model.address);
    if(action==AddressOptionActionDefault)
    {
        if(model.classic)
        {
            return;
        }
        [MBProgressHUD showProgressMessage:@"正在设定"];
        [MyPageHttpTool postDefaultAddressId:model.idd token:token success:^(BOOL result, NSString *msg) {
            if (result) {
                [MBProgressHUD showSuccessMessage:msg];
                model.classic=YES;
                [self.dataSource removeObject:model];
                for (AddressModel* mo in self.dataSource) {
                    mo.classic=NO;
                }
                [self.dataSource insertObject:model atIndex:0];
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }
    else if(action==AddressOptionActionDelete)
    {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该地址吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showProgressMessage:@"正在删除"];
            [MyPageHttpTool postDeleteAddressId:model.idd token:token success:^(BOOL result, NSString *msg) {
                if (result) {
                    [MBProgressHUD showSuccessMessage:msg];
                    NSInteger ind=[self.dataSource indexOfObject:model];
                    [self.dataSource removeObject:model];
                    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:ind] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self scrollViewDidScroll:self.tableView];
                }
                else
                {
                    [MBProgressHUD showErrorMessage:msg];
                }
            }];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else if(action==AddressOptionActionEdit)
    {
        AddressAddNewFormTableViewController* add=[[AddressAddNewFormTableViewController alloc]init];
        add.editAddress=model;
        [self.navigationController pushViewController:add animated:YES];
    }
}

#pragma actions

-(void)bottomToolBarButtonClicked
{
    [self.navigationController pushViewController:[[AddressAddNewFormTableViewController alloc]init] animated:YES];
}

@end
