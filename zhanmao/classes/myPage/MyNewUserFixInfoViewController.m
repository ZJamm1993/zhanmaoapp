//
//  MyNewUserFixInfoViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/5.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyNewUserFixInfoViewController.h"
#import "MyPageHttpTool.h"

@interface MyNewUserFixInfoViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *headerTextField;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *positionTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation MyNewUserFixInfoViewController
{
    NSString* avatar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"补全个人信息";
    
    self.headerImageView.layer.cornerRadius=self.headerImageView.layer.frame.size.width/2;
    self.headerImageView.clipsToBounds=YES;
    
    self.submitButton.layer.cornerRadius=4;
    self.submitButton.clipsToBounds=YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.headerTextField) {
        UIImagePickerController* pick=[[UIImagePickerController alloc]init];
        pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate=self;
        pick.allowsEditing=YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self presentViewController:pick animated:YES completion:nil];
        }
        return NO;
    }
    return YES;
}

#pragma mark imagepickercontroller delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage* pic=[info valueForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [MBProgressHUD showProgressMessage:@"正在上传图片"];
    [MyPageHttpTool uploadAvatar:pic token:[UserModel token] success:^(NSString *imageUrl) {
        
        [MBProgressHUD hide];
        
        
        if(imageUrl.length>0)
        {
            avatar=imageUrl;
            self.headerImageView.image=pic;
            [MBProgressHUD showSuccessMessage:@"已上传"];
        }
        else
        {
            NSLog(@"fail image");
            [MBProgressHUD showErrorMessage:@"上传失败"];
        }
    }];
    //    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark actions

- (IBAction)submitClick:(id)sender {
    NSString* user_nicename=self.nicknameTextField.text;
    NSString* position=self.positionTextField.text;
    NSString* user_email=self.emailTextField.text;
    
    if (avatar.length==0) {
        [MBProgressHUD showErrorMessage:@"请上传头像"];
        return;
    }
    if (user_nicename.length==0) {
        [MBProgressHUD showErrorMessage:@"请填写昵称"];
        return;
    }
    if (position.length==0) {
        [MBProgressHUD showErrorMessage:@"请填写职务"];
        return;
    }
    if (![user_email isEMailAddress]) {
        [MBProgressHUD showErrorMessage:@"请填写正确邮箱"];
        return;
    }
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:avatar forKey:@"avatar"];
    [dic setValue:user_nicename forKey:@"user_nicename"];
    [dic setValue:position forKey:@"position"];
    [dic setValue:user_email forKey:@"user_email"];
    
    [dic setValue:[UserModel token] forKey:@"access_token"];
    
    [MBProgressHUD showProgressMessage:@"正在提交"];
    [MyPageHttpTool postPersonalInfo:dic success:^(BOOL result, NSString *msg) {
        if (result) {
            [MBProgressHUD showSuccessMessage:msg];
            UserModel* u=[[UserModel alloc]initWithDictionary:dic];
            [UserModel saveUser:u];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
    }];
}

@end
