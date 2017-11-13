//
//  ExhibitionListViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionListViewController.h"
#import "ExhibitionLargeCardTableViewCell.h"

#import "ZhuchangFormTableViewController.h"
#import "ExhibitionExamplesViewController.h"

@interface ExhibitionListViewController ()

@end

@implementation ExhibitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=[NSString stringWithFormat:@"%dxx案例",(int)self.type];;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionLargeCardTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeCardTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExhibitionExamplesViewController* exh=[[UIStoryboard storyboardWithName:@"MainPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ExhibitionExamplesViewController"];
    exh.type=self.type;
    [self.navigationController pushViewController:exh animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)bottomToolBarButtonClicked
{
    ZhuchangFormTableViewController* zhu=[[ZhuchangFormTableViewController alloc]init];
    zhu.type=self.type;
    [self.navigationController pushViewController:zhu animated:YES];
}

@end
