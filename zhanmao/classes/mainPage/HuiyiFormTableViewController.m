//
//  HuiyiFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/10.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "HuiyiFormTableViewController.h"
#import "StepsHeaderView.h"

@interface HuiyiFormTableViewController ()

@end

@implementation HuiyiFormTableViewController

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

-(NSInteger)type
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(void)setCurrentStep:(BaseFormStep *)currentStep
{
    [super setCurrentStep:currentStep];
    NSMutableArray* stepTitles=[NSMutableArray array];
    for (BaseFormStep* ste in self.formSteps.steps) {
        NSString* str=ste.title;
        if (str.length==0) {
            str=@" ";
        }
        [stepTitles addObject:str];
    }
    [self.tableView setTableHeaderView:[StepsHeaderView headerWithTitles:stepTitles currentStep:self.stepInteger]];
    self.title=@"专业买家邀约服务";
}

@end
