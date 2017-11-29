//
//  TravellingQuestionsViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/29.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TravellingQuestionsViewController.h"
#import "TravellingHttpTool.h"

@interface TravellingQuestionsViewController ()

@end

@implementation TravellingQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

-(void)loadFormJson
{
    [TravellingHttpTool getTravelQuestionnaire:^(BaseFormStepsModel *steps) {
        self.formSteps=steps;
        [self.tableView reloadData];
    } cache:NO failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submit
{
    BaseFormModel* requiredModel=[self.formSteps requiredModelWithStep:self.stepInteger];
    if (requiredModel) {
        NSString* warning=requiredModel.hint;
        if (warning.length==0) {
            warning=requiredModel.name;
        }
        [MBProgressHUD showErrorMessage:warning];
        return;
    }
    if (self.stepInteger<self.formSteps.steps.count-1) {
        BaseFormTableViewController* nextPage=(BaseFormTableViewController*)[[[self class]alloc]init];
        nextPage.stepInteger=self.stepInteger+1;
        nextPage.formSteps=self.formSteps;
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    else
    {
        //        [MBProgressHUD showSuccessMessage:@"最后一页了"];
        [MBProgressHUD showProgressMessage:@"正在提交..."];
        NSMutableDictionary* paras=[NSMutableDictionary dictionaryWithDictionary:[self.formSteps parameters]];
        NSLog(@"%@",paras);
        [TravellingHttpTool postTravelQuestionnaireParams:paras success:^(BOOL result, NSString *msg) {
            if (result) {
                [MBProgressHUD showSuccessMessage:msg];
                [self.navigationController popViewControllerAnimated:YES];
                if (self.completionBlock) {
                    self.completionBlock();
                }
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }
}

@end
