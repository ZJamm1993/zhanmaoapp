//
//  ZhuchangFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZhuchangFormTableViewController.h"

@interface ZhuchangFormTableViewController ()

@end

@implementation ZhuchangFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadFormJson
{
    [FormHttpTool getCustomTableListByType:[self type] success:^(BaseFormStepsModel *step) {
        self.formSteps=step;
        [self.tableView reloadData];
    } failure:^(NSError *err) {
        
    }];

}

@end
