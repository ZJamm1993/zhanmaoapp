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

#import "MyPageHttpTool.h"
#import "MyPageOneTextFieldTableViewController.h"

@interface MyPersonalInfoViewController ()<MyPageOneTextFieldTableViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSArray* cellModelsArray;
    UserModel* user;
}
@end

@implementation MyPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"个人资料";
    
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
    
    user=[UserModel getUser];
    cellModelsArray=[NSArray arrayWithObjects:
                     [NSArray arrayWithObjects:
                      [MyPageCellModel modelWithTitle:@"头像" image:@"" detail:user.avatar identifier:@"avatar" type:MyPageCellModelTypeImage],
                      [MyPageCellModel modelWithTitle:@"昵称" image:@"" detail:user.user_nicename identifier:@"user_nicename"],
//                      [MyPageCellModel modelWithTitle:@"电话" image:@"" detail:user.mobile identifier:@"mo" type:MyPageCellModelTypePhone],
                      [MyPageCellModel modelWithTitle:@"职位" image:@"" detail:user.position identifier:@"position"],
                      [MyPageCellModel modelWithTitle:@"邮箱" image:@"" detail:user.user_email identifier:@"user_email" type:MyPageCellModelTypeMail], nil],
                     nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableviews

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
        [cell.image sd_setImageWithURL:[mo.detail urlWithMainUrl] placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
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
        UIImagePickerController* pick=[[UIImagePickerController alloc]init];
        pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate=self;
        pick.allowsEditing=YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self presentViewController:pick animated:YES completion:nil];
        }
    }
    else
    {
        MyPageOneTextFieldTableViewController* myEdit=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyPageOneTextFieldTableViewController"];
        myEdit.presetString=mo.detail;
        myEdit.editingType=mo.type;
        myEdit.title=[NSString stringWithFormat:@"设置%@",mo.title];
        myEdit.delegate=self;
        myEdit.cellModel=mo;
        [self.navigationController pushViewController:myEdit animated:YES];
    }
}

#pragma mark mypageOneTextfieldtableviewcontroller delegate

-(void)myPageOneTextFieldTableViewController:(MyPageOneTextFieldTableViewController *)viewController didFinishTexting:(NSString *)text
{
    //do commit then pop it;
    NSLog(@"%@",viewController);
    NSLog(@"%@",text);
    
    MyPageCellModel* model=viewController.cellModel;
    model.detail=text;
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    
    [dic setValue:[UserModel token] forKey:@"access_token"];
    
    for (NSArray* arr in cellModelsArray) {
        for (MyPageCellModel* mo in arr) {
            [dic setValue:mo.detail forKey:mo.identifier];
        }
    }
    
    [MBProgressHUD showProgressMessage:@"正在修改"];
    [MyPageHttpTool postPersonalInfo:dic success:^(BOOL result, NSString *msg) {
        if (result) {
            
            [MBProgressHUD showSuccessMessage:msg];
            
            if ([model.identifier isEqualToString:@"user_nicename"]) {
                user.user_nicename=model.detail;
            }
            else if ([model.identifier isEqualToString:@"position"]) {
                user.position=model.detail;
            }
            else if ([model.identifier isEqualToString:@"mobile"]) {
                user.mobile=model.detail;
            }
            else if ([model.identifier isEqualToString:@"user_email"]) {
                user.user_email=model.detail;
            }
            [UserModel saveUser:user];
            [self.tableView reloadData];
            [viewController.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
    }];
}

#pragma mark uiimagepickercontrollerdelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* pic=[info valueForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [MBProgressHUD showProgressMessage:@"正在上传图片"];
    [MyPageHttpTool uploadAvatar:pic token:[UserModel token] success:^(NSString *imageUrl) {
        
        [MBProgressHUD hide];
        if(imageUrl.length>0)
        {
            NSMutableDictionary* dic=[NSMutableDictionary dictionary];
            
            [dic setValue:[UserModel token] forKey:@"access_token"];
            
            for (NSArray* arr in cellModelsArray) {
                for (MyPageCellModel* mo in arr) {
                    if ([mo.identifier isEqualToString:@"avatar"]) {
                        mo.detail=imageUrl;
                    }
                    [dic setValue:mo.detail forKey:mo.identifier];
                }
            }
            
            [MyPageHttpTool postPersonalInfo:dic success:^(BOOL result, NSString *msg) {
                if (result) {
                    [MBProgressHUD showSuccessMessage:msg];
                    
                    UserModel* us=[UserModel getUser];
                    us.avatar=imageUrl;
                    [UserModel saveUser:us];
                    [self.tableView reloadData];
                }
                else
                {
                    [MBProgressHUD showErrorMessage:msg];
                    
                }
                
            }];
        }
        else
        {
            NSLog(@"fail image");
            [MBProgressHUD showErrorMessage:@"上传失败"];
        }
    }];
    
//    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
