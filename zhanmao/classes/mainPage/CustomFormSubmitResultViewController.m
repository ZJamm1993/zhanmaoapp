
//
//  CustomFormSubmitResultViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/13.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomFormSubmitResultViewController.h"

@interface CustomFormSubmitResultViewController ()

@end

@implementation CustomFormSubmitResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.goHomeButton setBackgroundColor:_mainColor];
    [self.goHomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.goHomeButton.layer setCornerRadius:4];
    //[UIColor viewFlipsideBackgroundColor];
    self.title=@"提交成功";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
