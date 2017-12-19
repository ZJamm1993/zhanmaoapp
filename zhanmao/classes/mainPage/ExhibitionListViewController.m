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

#import "MainPageHttpTool.h"

#import "MyLoginViewController.h"

@interface ExhibitionListViewController ()

@end

@implementation ExhibitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=[NSString stringWithFormat:@"%dxx案例",(int)self.type];;
    // Do any additional setup after loading the view.
    [self refresh];
}

-(void)refresh
{
    
    [MainPageHttpTool getCustomShowingListByType:[NSString stringWithFormat:@"%d",(int)self.type] cache:NO success:^(NSArray *result) {
        self.dataSource=[NSMutableArray arrayWithArray:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
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
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionLargeCardTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeCardTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    BaseModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    cell.label.text=mo.name;
    [cell.image sd_setImageWithURL:[mo.thumb urlWithMainUrl]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExhibitionExamplesViewController* exh=[[UIStoryboard storyboardWithName:@"MainPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ExhibitionExamplesViewController"];
    BaseModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    exh.title=mo.name;
    exh.type=self.type;
    exh.cid=mo.idd;
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
//    if ([UserModel token].length==0) {
//        [MBProgressHUD showErrorMessage:AskToLoginDescription];
//        [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
//        return;
//    }
    ZhuchangFormTableViewController* zhu=[[ZhuchangFormTableViewController alloc]init];
    zhu.type=self.type;
    [self.navigationController pushViewController:zhu animated:YES];
}

@end
