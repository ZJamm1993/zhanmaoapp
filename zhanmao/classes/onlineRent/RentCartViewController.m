//
//  RentCartViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentCartViewController.h"
#import "RentCartEditTableViewCell.h"

@interface RentCartViewController ()

//@property (nonatomic,assign) BOOL editing;

@end

@implementation RentCartViewController
{
    BOOL custom_editing;
    UIBarButtonItem* editButtonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RentCartEditTableViewCell" bundle:nil] forCellReuseIdentifier:@"RentCartEditTableViewCell"];
    
    editButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editingToggle)];
    self.navigationItem.rightBarButtonItem=editButtonItem;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentCartEditTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentCartEditTableViewCell" forIndexPath:indexPath];
    cell.editing=self.editing;
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
}

@end
