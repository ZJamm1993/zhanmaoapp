//
//  MyLoginViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/15.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyLoginViewController.h"

@interface MyLoginViewController ()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fieldBgs;

@end

@implementation MyLoginViewController

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

@end
