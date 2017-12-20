//
//  PayResultViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/6.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "PayResultViewController.h"

@interface PayResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *goHomeButton;
@property (weak, nonatomic) IBOutlet UIButton *checkOrderButton;

@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.goHomeButton setBackgroundColor:_mainColor];
    [self.goHomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.goHomeButton.layer setCornerRadius:4];
    
    [self.checkOrderButton setBackgroundColor:[UIColor whiteColor]];
    [self.checkOrderButton setTitleColor:gray_2 forState:UIControlStateNormal];
    [self.checkOrderButton.layer setCornerRadius:4];
    [self.checkOrderButton.layer setBorderColor:gray_6.CGColor];
    [self.checkOrderButton.layer setBorderWidth:0.5];
    
    self.title=@"支付成功";
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

#pragma mark actions

- (IBAction)goHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkOrder:(id)sender {
    if (self.orderDetailController) {
        [self.navigationController pushViewController:self.orderDetailController animated:YES];
    }
}

@end
