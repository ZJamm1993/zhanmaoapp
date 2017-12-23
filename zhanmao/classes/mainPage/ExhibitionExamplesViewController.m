//
//  ExhibitionExamplesViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionExamplesViewController.h"
#import "ExhibitionLargeRectTableViewCell.h"

#import "ZhuchangFormTableViewController.h"
#import "ExhibitionPictureViewController.h"

#import "MainPageHttpTool.h"

#import "MyLoginViewController.h"

@interface ExhibitionExamplesViewController ()

@end

@implementation ExhibitionExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refresh];
}

-(void)refresh
{
    [MainPageHttpTool getCustomShowingCaseListByCid:self.cid cache:NO success:^(NSArray *result) {
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

#pragma mark tableViews

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 14;
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
    ExhibitionLargeRectTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeRectTableViewCell" forIndexPath:indexPath];
    BaseModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    cell.title.text=mo.post_title;
    [cell.image sd_setImageWithURL:[mo.thumb urlWithMainUrl]];
    cell.detailTitle.text=[NSString stringWithFormat:@"图(%ld张)",(long)mo.smeta.count];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExhibitionPictureViewController* ep=[[ExhibitionPictureViewController alloc]init];
    BaseModel* mo=[self.dataSource objectAtIndex:indexPath.section];
    ep.type=self.type;
    NSMutableArray* images=[NSMutableArray array];
    for (NSString* strin in mo.smeta) {
        NSString* str=[ZZUrlTool fullUrlWithTail:strin];
        [images addObject:str];
    }
    ep.images=images;
    ep.pictureTitle=mo.post_title;
    [self.navigationController pushViewController:ep animated:YES];
}

#pragma mark actions

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
