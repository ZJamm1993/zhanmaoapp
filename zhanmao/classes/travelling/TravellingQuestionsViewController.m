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
    
    if(self.showingImageUrl)
    {
        if (![self.showingImageUrl containsString:[ZZUrlTool main]]) {
            self.showingImageUrl=[ZZUrlTool fullUrlWithTail:self.showingImageUrl];
        }
        UIImageView* head=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.width/2.27)];
        [self.tableView setTableHeaderView:head];
        [head sd_setImageWithURL:[NSURL URLWithString:self.showingImageUrl]];
    }
    // Do any additional setup after loading the view.
}

-(void)loadFormJson
{
    [TravellingHttpTool getTravelQuestionnaire:^(BaseFormStepsModel *steps) {
        self.formSteps=steps;
        if (self.showingTitle) {
            self.title=self.showingTitle;
        }
        [self.tableView reloadData];
    } cache:NO failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submitToServer
{
    //        [MBProgressHUD showSuccessMessage:@"最后一页了"];
    [MBProgressHUD showProgressMessage:@"正在提交..."];
    NSMutableDictionary* paras=[NSMutableDictionary dictionaryWithDictionary:[self.formSteps parametersWithModifiedKey:@"data"]];
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


@end
