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
#import "UIImage+GIF.h"

@interface ExhibitionListViewController ()

@end

@implementation ExhibitionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=[NSString stringWithFormat:@"%ldxx案例",(long)self.type];;
    // Do any additional setup after loading the view.
    [self refresh];
    
    UIImageView* head=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.width/2.27)];
    [self.tableView setTableHeaderView:head];
    
    if ([self.title containsString:@"论坛"]||[self.title containsString:@"活动"]) {
//        head.image=[UIImage imageNamed:@"论坛-活动.gif"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"somegif" ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage* gifImage=[UIImage sd_animatedGIFWithData:data];
        head.image = gifImage;
        
//        //读取gif图片数据
//        NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"somegif" ofType:@"gif"]];
//        //UIWebView生成
//        UIWebView *imageWebView = [[UIWebView alloc] initWithFrame:head.frame];
//        imageWebView.contentMode=UIViewContentModeScaleToFill;
//        //用户不可交互
//        imageWebView.userInteractionEnabled = NO;
//        //加载gif数据
//        [imageWebView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//        //视图添加此gif控件
//        [self.tableView setTableHeaderView:imageWebView];
    }
    else
    {
        head.image=[UIImage imageNamed:@"somejpg.jpg"];
    }
//    else if ([self.title containsString:@"展台"]) {
//        head.image=[UIImage imageNamed:@"展台.jpg"];
//    }
//    else if ([self.title containsString:@"展厅"]) {
//        head.image=[UIImage imageNamed:@"展厅.jpg"];
//    }
//    else if ([self.title containsString:@"主场"]) {
//        head.image=[UIImage imageNamed:@"主场.jpg"];
//    }
}

-(void)refresh
{
    
    [MainPageHttpTool getCustomShowingListByType:[NSString stringWithFormat:@"%ld",(long)self.type] cache:NO success:^(NSArray *result) {
        self.dataSource=[NSMutableArray arrayWithArray:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark tableviews

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

#pragma mark actions

-(void)bottomToolBarButtonClicked
{
    ZhuchangFormTableViewController* zhu=[[ZhuchangFormTableViewController alloc]init];
    zhu.type=self.type;
    [self.navigationController pushViewController:zhu animated:YES];
}

@end
