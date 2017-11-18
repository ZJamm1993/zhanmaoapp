//
//  AddressAddNewFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/18.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "AddressAddNewFormTableViewController.h"

@interface AddressAddNewFormTableViewController ()

@end

@implementation AddressAddNewFormTableViewController

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
    BaseFormStepsModel* step=[FormHttpTool stepsFromFileName:@"address.txt"];
    self.formSteps=step;
    [self.tableView reloadData];
}



@end
