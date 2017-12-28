//
//  MyHelpCenterTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyHelpCenterTableViewController.h"
#import "MyPageHttpTool.h"
#import "MyPageSimpleTableViewCell.h"
#import "BaseWebViewController.h"
#import "MyPageHelpHeaderCell.h"

@interface MyHelpCenterTableViewController ()
{
    NSString* consumer_phone;
    NSString* consumer_qq;
}

@end

@implementation MyHelpCenterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"帮助中心";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageSimpleTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPageSimpleTableViewCell"];
    
    [self showLoadMoreView];
    [self refresh];
}

#pragma mark datas

-(void)refresh
{
    [MyPageHttpTool getHelpCenterListPage:1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=1;
        }
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
    [MyPageHttpTool getStandardConfigCache:NO success:^(NSDictionary *config) {
        if (config) {
            consumer_phone=[config valueForKey:@"consumer_phone"];
            consumer_qq=[config valueForKey:@"consumer_qq"];
            [self.tableView reloadData];
        }
    }];
}

-(void)loadMore
{
    [MyPageHttpTool getHelpCenterListPage:self.currentPage+1 pagesize:self.pageSize cache:NO success:^(NSArray *result) {
        [self.dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        if (result.count>0) {
            self.currentPage=self.currentPage+1;
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1)
    {
        return self.dataSource.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==1) {
        BaseModel* ba=[self.dataSource objectAtIndex:indexPath.row];
        MyPageSimpleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageSimpleTableViewCell" forIndexPath:indexPath];
        cell.textLabel.text=ba.post_title;
        cell.detailTextLabel.text=nil;
        return cell;
    }
    else if(indexPath.section==0)
    {
        MyPageHelpHeaderCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageHelpHeaderCell" forIndexPath:indexPath];
        
        //test
        
        cell.detailLeft.text=consumer_phone;
        cell.detailRight.text=consumer_qq;
        
        [cell.buttonLeft setTitle:cell.detailLeft.text forState:UIControlStateSelected];
        [cell.buttonRight setTitle:cell.detailRight.text forState:UIControlStateSelected];
        
        //test
        
        [cell.buttonLeft addTarget:self action:@selector(phoneCallClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonRight addTarget:self action:@selector(qqCallClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        BaseModel* ba=[self.dataSource objectAtIndex:indexPath.row];
        BaseWebViewController* web=[[BaseWebViewController alloc]initWithUrl:[HTML_HelpDetail urlWithMainUrl]];
        web.title=ba.post_title;
        web.idd=ba.idd.integerValue;
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark actions

-(void)phoneCallClick:(UIButton*)btn
{
    NSString* pho=[btn titleForState:UIControlStateSelected];
    if (pho.length>0) {
        NSString* str=[NSString stringWithFormat:@"tel://%@",pho];
        NSURL* phone=[NSURL URLWithString:str];
        if ([[UIApplication sharedApplication]canOpenURL:phone] ) {
            [[UIApplication sharedApplication]openURL:phone];
        }
        else{
            [MBProgressHUD showErrorMessage:@"设备不支持拨打电话"];
        }
    }
}

-(void)qqCallClick:(UIButton*)btn
{
    NSString* qq=[btn titleForState:UIControlStateSelected];
    if (qq.length>0) {
        NSString* qqu=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qq];
        NSURL* qqurl=[NSURL URLWithString:qqu];
        
        [[UIApplication sharedApplication]openURL:qqurl];
    }
}

@end
