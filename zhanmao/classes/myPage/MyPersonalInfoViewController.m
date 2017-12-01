//
//  MyPersonalInfoViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPersonalInfoViewController.h"
#import "MyPageSimpleTableViewCell.h"
#import "MyPageSimpleImageTableViewCell.h"
#import "MyPageCellModel.h"

#import "MyPageOneTextFieldTableViewController.h"

@interface MyPersonalInfoViewController ()<MyPageOneTextFieldTableViewControllerDelegate>
{
    NSArray* cellModelsArray;
}
@end

@implementation MyPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageSimpleTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPageSimpleTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageSimpleImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyPageSimpleImageTableViewCell"];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetCellsModels];
}

-(void)resetCellsModels
{
    
    cellModelsArray=[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"头像" image:@"" detail:@"" identifier:@"" type:MyPageCellModelTypeImage],
                      [MyPageCellModel modelWithTitle:@"昵称" image:@"" detail:@"" identifier:@""],
                      [MyPageCellModel modelWithTitle:@"电话" image:@"" detail:@"" identifier:@"" type:MyPageCellModelTypePhone],
                      [MyPageCellModel modelWithTitle:@"职位" image:@"" detail:@"" identifier:@""],
                      [MyPageCellModel modelWithTitle:@"邮箱" image:@"" detail:@"" identifier:@"" type:MyPageCellModelTypeMail], nil],
                     nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
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
    NSArray* arr=[cellModelsArray objectAtIndex:sec];
    MyPageCellModel* mo=[arr objectAtIndex:row];
    
    if (mo.type==MyPageCellModelTypeImage) {
        MyPageSimpleImageTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageSimpleImageTableViewCell" forIndexPath:indexPath];
        cell.title.text=mo.title;
        return cell;
    }
    MyPageSimpleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageSimpleTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text=mo.title;
    cell.imageView.image=[UIImage imageNamed:mo.image];
    cell.detailTextLabel.text=mo.detail;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sec=indexPath.section;
    NSInteger row=indexPath.row;
    NSArray* arr=[cellModelsArray objectAtIndex:sec];
    MyPageCellModel* mo=[arr objectAtIndex:row];
    if (mo.type==MyPageCellModelTypeImage) {
        // select image;
    }
    else
    {
        MyPageOneTextFieldTableViewController* myEdit=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyPageOneTextFieldTableViewController"];
        myEdit.presetString=mo.detail;
        myEdit.editingType=mo.type;
        myEdit.title=[NSString stringWithFormat:@"设置%@",mo.title];
        myEdit.delegate=self;
        [self.navigationController pushViewController:myEdit animated:YES];
    }
}

-(void)myPageOneTextFieldTableViewController:(MyPageOneTextFieldTableViewController *)viewController didFinishTexting:(NSString *)text
{
    //do commit then pop it;
    NSLog(@"%@",viewController);
    NSLog(@"%@",text);
}

@end
