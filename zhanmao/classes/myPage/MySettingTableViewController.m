//
//  MySettingTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MySettingTableViewController.h"
#import "MyPageCellModel.h"
#import "MyPageSimpleTableViewCell.h"
#import "MyPageButtonTableViewCell.h"

@interface MySettingTableViewController ()
{
    NSArray* cellModelsArray;
}
@end

@implementation MySettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"设置";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageButtonTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPageButtonTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageSimpleTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPageSimpleTableViewCell"];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshData];
}

-(void)refreshData
{
    NSString* version=[NSString stringWithFormat:@"v%@",[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"]];
    NSInteger mb=[[SDImageCache sharedImageCache]getSize]/1024/1024;
    NSString* cacheStr=[NSString stringWithFormat:@"%ldMB",(long)mb];
    cellModelsArray=[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"分享给好友" image:@"set_share" detail:@"" identifier:@""],
                      [MyPageCellModel modelWithTitle:@"当前版本" image:@"set_version" detail:version identifier:@""],
                      [MyPageCellModel modelWithTitle:@"清空缓存" image:@"set_clean" detail:cacheStr identifier:@"clean"],nil],
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"去评价" image:@"set_gojudge" detail:@"" identifier:@""],
                      [MyPageCellModel modelWithTitle:@"关于" image:@"set_about" detail:@"" identifier:@"MyAboutUsViewController"],nil],
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"" image:@"" detail:@"" identifier:@"logout"],nil],
                     nil];
    [self.tableView reloadData];
}

-(void)refresh
{
    [self refreshData];
    //[self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView delegate & datasource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==tableView.numberOfSections-1) {
        return 100;
    }
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return cellModelsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* arr=[cellModelsArray objectAtIndex:section];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    if (sec==tableView.numberOfSections-1) {
        MyPageButtonTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageButtonTableViewCell" forIndexPath:indexPath];
        [cell.button setTitle:@"安全退出" forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        NSArray* arr=[cellModelsArray objectAtIndex:sec];
        MyPageCellModel* mo=[arr objectAtIndex:row];
        
        MyPageSimpleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageSimpleTableViewCell" forIndexPath:indexPath];
        cell.textLabel.text=mo.title;
        //cell.imageView.image=[UIImage imageNamed:mo.image];
        cell.detailTextLabel.text=mo.detail;
//        cell.accessoryType=mo.detail.length>0?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray* arr=[cellModelsArray objectAtIndex:indexPath.section];
    MyPageCellModel* mo=[arr objectAtIndex:indexPath.row];
    NSLog(@"%@",mo.identifier);
    
    if ([mo.identifier isEqualToString:@"clean"]) {
        [[SDImageCache sharedImageCache]clearMemory];
        [[SDImageCache sharedImageCache]clearDiskOnCompletion:nil];
        [self refreshData];
    }
    else if([mo.identifier isEqualToString:@"logout"])
    {
        [self logOut];
    }
    else
    {
        if (mo.identifier.length>0) {
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:mo.identifier] animated:YES];
        }
    }
}

-(void)logOut
{
    [UserModel saveToken:@""];
    [UserModel deleteUser];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
