//
//  RentOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderTableViewController.h"
#import "RentOrderTableViewCell.h"

@interface RentOrderTableViewController ()

@end

@implementation RentOrderTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"RentOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"RentOrderTableViewCell"];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataSource=[NSMutableArray arrayWithArray:[RentOrderDataSource rentOrderDatasWithType:self.type]];
    [self.tableView reloadData];
    
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
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentOrderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentOrderTableViewCell" forIndexPath:indexPath];
    
    RentOrderModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    cell.model=mo;
    
    return cell;
}

@end
