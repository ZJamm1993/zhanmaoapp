//
//  RentCartTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentCartTableViewController.h"
#import "RentCartEditTableViewCell.h"
#import "RentCartEditToolBar.h"

#import "ProductCreateOrderTableViewController.h"
#import "ProductWebDetailViewController.h"

@interface RentCartTableViewController ()<RentCartEditTableViewCellDelegate>

@end

@implementation RentCartTableViewController
{
    BOOL custom_editing;
    UIBarButtonItem* editButtonItem;
    RentCartEditToolBar* editToolBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"租赁车";
    [self.bottomButton removeFromSuperview];
    
    editButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editingToggle)];
    self.navigationItem.rightBarButtonItem=editButtonItem;
    
    editToolBar=[[[UINib nibWithNibName:@"RentCartEditToolBar" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    CGRect fr=self.bottomToolBar.bounds;
    fr.size.height=64;
    editToolBar.frame=fr;
    [self.bottomToolBar insertSubview:editToolBar atIndex:0];
    
    editToolBar.editing=self.editing;
    [editToolBar.actionButton addTarget:self action:@selector(editToolBarAction) forControlEvents:UIControlEventTouchUpInside];
    [editToolBar.selectAllButton addTarget:self action:@selector(editToolBarSelectAll) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.dataSource.count==0) {
        [self refresh];
    }
}

-(void)refresh
{
    [RentHttpTool getRentCartsSuccess:^(NSArray *result) {
        self.dataSource=[NSMutableArray arrayWithArray:result];
        [self.tableView reloadData];
    }phone:[UserModel getUser].mobile failure:^(NSError *error) {
        
    }];
}

-(void)editingToggle
{
    self.editing=!self.editing;
    editButtonItem.title=self.editing?@"完成":@"编辑";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentCartModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    RentCartEditTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentCartEditTableViewCell" forIndexPath:indexPath];
    cell.editing=self.editing;
    
    cell.cartModel=mo;
    cell.delegate=self;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.editing) {
        ProductWebDetailViewController* prod=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductWebDetailViewController"];
        prod.goodModel=[[self.dataSource objectAtIndex:indexPath.row]product];
        [self.navigationController pushViewController:prod animated:YES];
    }
}

-(BOOL)isEditing
{
    return custom_editing;
}

-(void)setEditing:(BOOL)editing
{
//    [super setEditing:editing];
//    _editing=editing;
    custom_editing=editing;
    
    [self.tableView reloadData];
    editToolBar.editing=editing;
}

-(void)rentCartEditTableViewCell:(RentCartEditTableViewCell *)cell deleteCartModel:(RentCartModel *)cartModel
{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除商品吗？删除后无法恢复" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([self.dataSource containsObject:cartModel]) {
            NSInteger ind=[self.dataSource indexOfObject:cartModel];
            [self.dataSource removeObject:cartModel];
            [RentHttpTool removeRentCarts:[NSArray arrayWithObject:cartModel] phone:[UserModel getUser].mobile success:nil failure:nil];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:ind inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)rentCartEditTableViewCell:(RentCartEditTableViewCell *)cell didChangeModel:(RentCartModel *)cartModel
{
    BOOL isSelectedAll=YES;
    for (RentCartModel* mo in self.dataSource) {
        if(mo.selected==NO)
        {
            isSelectedAll=NO;
        }
        [RentHttpTool changeRentCart:mo phone:[UserModel getUser].mobile];
    }
    [self.tableView reloadData];
    editToolBar.seletedAll=isSelectedAll;
}

-(void)editToolBarAction
{
    NSMutableArray* arrToDel=[NSMutableArray array]; //Models
    NSMutableArray* indToDel=[NSMutableArray array]; //NSIndexPath
    for (NSInteger i=0;i<self.dataSource.count;i++) {
        RentCartModel* mo=[self.dataSource objectAtIndex:i];
        if(mo.selected==YES)
        {
            [arrToDel addObject:mo];
            NSIndexPath* indexPath=[NSIndexPath indexPathForRow:i inSection:0];
            [indToDel addObject:indexPath];
        }
    }
    if (self.editing) {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除商品吗？删除后无法恢复" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self.dataSource removeObjectsInArray:arrToDel];
            [RentHttpTool removeRentCarts:arrToDel phone:[UserModel getUser].mobile success:nil failure:nil];
            [self.tableView deleteRowsAtIndexPaths:indToDel withRowAnimation:UITableViewRowAnimationAutomatic];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        //go to pay
        if (indToDel.count>0) {
            ProductCreateOrderTableViewController* rent=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductCreateOrderTableViewController"];
            rent.cartObjects=[NSArray arrayWithArray:arrToDel];
            [self.navigationController pushViewController:rent animated:YES];
        }
    }
}

-(void)editToolBarSelectAll
{
    BOOL isSelectedAll=YES;
    for (RentCartModel* mo in self.dataSource) {
        if(mo.selected==NO)
        {
            isSelectedAll=NO;
        }
    }
    
    BOOL shouldSelectedAll=!isSelectedAll;
    
    for (RentCartModel* mo in self.dataSource) {
        mo.selected=shouldSelectedAll;
    }
    
    [self.tableView reloadData];
    
    editToolBar.seletedAll=shouldSelectedAll;
}

@end
