//
//  MyLoginViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/15.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyLoginViewController.h"
#import "MyPageHttpTool.h"

@interface MyLoginViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fieldBgs;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation MyLoginViewController

+(instancetype)loginViewController
{
    return [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyLoginViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"手机登录";
    
    for (UIView* viw in self.fieldBgs) {
        viw.layer.cornerRadius=4;
        
        if ([viw isKindOfClass:[UIButton class]]) {
            UIButton* btn=(UIButton*)viw;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:_mainColor];
        }
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions

- (IBAction)getCode:(id)sender {
    if ([self.mobileTextField.text isMobileNumber]) {
        self.getCodeButton.enabled=NO;
        [self startCountDownSeconds:60];
        
        [MBProgressHUD showProgressMessage:@"正在发送验证码"];
        [MyPageHttpTool getCodeWithMobile:self.mobileTextField.text success:^(BOOL sent, NSString *msg) {
            if (sent) {
                [MBProgressHUD showSuccessMessage:msg];
                [self.codeTextField becomeFirstResponder];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
                self.getCodeButton.enabled=YES;
            }
        }];
    }
    else
    {
        [MBProgressHUD showErrorMessage:@"请输入正确的手机号码"];
    }
}

- (IBAction)login:(id)sender {
    
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController presentViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyNewUserFixInfoNavigationController"] animated:YES completion:nil];
//    return ;
//    //test
    
    if (![self.mobileTextField.text isMobileNumber]) {
        [MBProgressHUD showErrorMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.codeTextField.text.length==0) {
        [MBProgressHUD showErrorMessage:@"请获取并输入验证码"];
        return;
    }
    
    [MBProgressHUD showProgressMessage:@"正在登录"];
    [MyPageHttpTool loginUserWithMobile:self.mobileTextField.text code:self.codeTextField.text success:^(NSString *token,BOOL newUser,NSString* msg) {
        [MBProgressHUD showSuccessMessage:msg];
        if (token.length>0) {
            [UserModel saveToken:token];
            [UserModel deleteUser];
            
            if (newUser) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.navigationController presentViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyNewUserFixInfoNavigationController"] animated:YES completion:nil];
            }
            else
            {
                [MyPageHttpTool getPersonalInfoToken:token success:^(UserModel *user,NSInteger code) {
                    [UserModel saveUser:user];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
    }];
}

#pragma mark countingdown

-(void)countingDownSeconds:(NSInteger)second
{
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重新发送",(long)second] forState:UIControlStateDisabled];
}

-(void)endingCountDown
{
    self.getCodeButton.enabled=YES;
}

@end
