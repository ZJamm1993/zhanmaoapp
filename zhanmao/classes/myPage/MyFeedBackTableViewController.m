//
//  MyFeedBackTableViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyFeedBackTableViewController.h"

@interface MyFeedBackTableViewController ()
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
- (IBAction)submit:(id)sender {
}

@end
