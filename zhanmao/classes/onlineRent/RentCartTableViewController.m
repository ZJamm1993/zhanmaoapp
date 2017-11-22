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
    editToolBar.frame=self.bottomToolBar.bounds;
    [self.bottomToolBar addSubview:editToolBar];
    
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
    } failure:^(NSError *error) {
        
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
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"n" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"y" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([self.dataSource containsObject:cartModel]) {
            [self.dataSource removeObject:cartModel];
            [self.tableView reloadData];
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
        [RentHttpTool changeRentCart:mo];
    }
    [self.tableView reloadData];
    editToolBar.seletedAll=isSelectedAll;
}

-(void)editToolBarAction
{
    if (self.editing) {
        NSMutableArray* arrToDel=[NSMutableArray array];
        NSMutableArray* indToDel=[NSMutableArray array];
        for (NSInteger i=0;i<self.dataSource.count;i++) {
            RentCartModel* mo=[self.dataSource objectAtIndex:i];
            if(mo.selected==YES)
            {
                [arrToDel addObject:mo];
                NSIndexPath* indexPath=[NSIndexPath indexPathForRow:i inSection:0];
                [indToDel addObject:indexPath];
            }
        }
        [self.dataSource removeObjectsInArray:arrToDel];
        [RentHttpTool removeRentCarts:arrToDel success:nil failure:nil];
        [self.tableView deleteRowsAtIndexPaths:indToDel withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        //go to pay
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
