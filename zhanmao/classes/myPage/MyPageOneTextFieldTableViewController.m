//
//  MyPageOneTextFieldTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageOneTextFieldTableViewController.h"

@interface MyPageOneTextFieldTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textingField;

@end

@implementation MyPageOneTextFieldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textingField.text=self.presetString;
    self.textingField.returnKeyType=UIReturnKeyDone;
    self.textingField.delegate=self;
    
    UIBarButtonItem* finishB=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(check)];
    self.navigationItem.rightBarButtonItem=finishB;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textingField becomeFirstResponder];
    
    //    if (self.textingField.text.length>0) {
    //        [self.textingField selectAll:self.textingField];
    //    }
    [self.textingField performSelector:@selector(selectAll:) withObject:nil afterDelay:0.01];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textingField resignFirstResponder];
}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

#pragma mark textfield

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self check];
    return YES;
}

#pragma mark actions

-(void)check
{
    if (self.editingType==MyPageCellModelTypePhone) {
        if (![self.textingField.text isMobileNumber]) {
            [MBProgressHUD showErrorMessage:@"请输入正确格式的手机号码"];
            return;
        }
    }
    else if (self.editingType==MyPageCellModelTypeMail) {
        if (![self.textingField.text isEMailAddress]) {
            [MBProgressHUD showErrorMessage:@"请输入正确格式的邮箱地址"];
            return;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(myPageOneTextFieldTableViewController:didFinishTexting:)]) {
        [self.delegate myPageOneTextFieldTableViewController:self didFinishTexting:self.textingField.text];
    }
}

@end
