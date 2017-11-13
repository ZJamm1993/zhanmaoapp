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

@interface ExhibitionExamplesViewController ()

@end

@implementation ExhibitionExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"xxx";
    self.tableView.separatorColor=[UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViews

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 14;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionLargeRectTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ExhibitionLargeRectTableViewCell" forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExhibitionPictureViewController* ep=[[ExhibitionPictureViewController alloc]init];
    ep.type=self.type;
    [self.navigationController pushViewController:ep animated:YES];
}

-(void)bottomToolBarButtonClicked
{
    ZhuchangFormTableViewController* zhu=[[ZhuchangFormTableViewController alloc]init];
    zhu.type=self.type;
    [self.navigationController pushViewController:zhu animated:YES];
}

@end
