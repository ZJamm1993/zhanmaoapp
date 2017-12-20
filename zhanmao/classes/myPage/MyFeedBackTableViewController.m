//
//  MyFeedBackTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyFeedBackTableViewController.h"
#import "MyPageHttpTool.h"

@interface MyFeedBackTableViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bg1;
@property (weak, nonatomic) IBOutlet UIView *bg2;
@property (weak, nonatomic) IBOutlet UILabel *textViewPlaceHolder;
@property (weak, nonatomic) IBOutlet UITextView *adviceTextView;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation MyFeedBackTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat borderCorner=5;
    self.bg1.layer.cornerRadius=borderCorner;
    self.bg2.layer.cornerRadius=borderCorner;
    self.submitButton.layer.cornerRadius=borderCorner;
    
    self.adviceTextView.delegate=self;
    self.contactTextField.delegate=self;
    
    [self.adviceTextView becomeFirstResponder];
    
    self.title=@"建议反馈";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark textfield and textview delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self performSelector:@selector(hidePlaceHolderIfNeed) withObject:nil afterDelay:0.01];
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark textview placeholder

-(void)hidePlaceHolderIfNeed
{
    self.textViewPlaceHolder.hidden=self.adviceTextView.text.length>0;
}

#pragma mark actions

- (IBAction)submit:(id)sender {
    NSString* advice=self.adviceTextView.text;
    if (advice.length==0) {
        [MBProgressHUD showErrorMessage:@"请输入建议"];
        return;
    }
    NSString* contact=self.contactTextField.text;
    if (contact.length==0) {
        [MBProgressHUD showErrorMessage:@"请输入邮箱或手机号码"];
        return;
    }
    if (![contact isEMailAddress]&&![contact isMobileNumber]) {
        [MBProgressHUD showErrorMessage:@"请输入正确的邮箱或手机号码"];
        return;
    }
    NSLog(@"commit advice:%@\ncontact:%@",advice,contact);
    
    [MyPageHttpTool postFeedbackContent:advice contact:contact token:[UserModel token] success:^(BOOL result, NSString *msg) {
        if (result) {
            [MBProgressHUD showSuccessMessage:msg];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
    }];
}

@end
