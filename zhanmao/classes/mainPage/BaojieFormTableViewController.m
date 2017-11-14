//
//  BaojieFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/10.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaojieFormTableViewController.h"
#import "CalculateFeesView.h"
#import "TotalFeeView.h"

@interface BaojieFormTableViewController ()
{
    CalculateFeesView* _smallFeeView;
    TotalFeeView* _totalFeeView;
}
@end

@implementation BaojieFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* headerIamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)];
    headerIamge.image=[UIImage imageNamed:@"chicken"];
    self.tableView.tableHeaderView=headerIamge;
    // Do any additional setup after loading the view.
    
    [self.bottomButton removeFromSuperview];
    
    _totalFeeView=[[[UINib nibWithNibName:@"TotalFeeView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    _totalFeeView.frame=self.bottomView.bounds;
    [_totalFeeView.submitButton addTarget:self action:@selector(orderSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_totalFeeView];
    
    _smallFeeView=[[[UINib nibWithNibName:@"CalculateFeesView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
//    _smallFeeView.frame=CGRectMake(0, 0, self.view.frame.size.w/
    _smallFeeView.widthConstraint.constant=self.view.frame.size.width;
//    self.tableView.tableFooterView=_smallFeeView;
    
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.0001;
    }
    return 10;
}
-(void)loadFormJson
{
    [FormHttpTool getCustomTableListByType:[self type] success:^(BaseFormStepsModel *step) {
        self.formSteps=step;
        [self.tableView reloadData];
        self.tableView.tableFooterView=nil;
        
        UIView* v=[[UIView alloc]initWithFrame:_smallFeeView.bounds];
        v.backgroundColor=[UIColor whiteColor];
        [_smallFeeView removeFromSuperview];
        [v addSubview:_smallFeeView];
        self.tableView.tableFooterView=v;
    } failure:^(NSError *err) {
        
    }];
    
}

-(NSInteger)type
{
    return 7;
}

-(void)valueChanged
{
    BaseFormModel* requiredModel=[self.formSteps requiredModelWithStep:self.stepInteger];
    if (requiredModel==nil) {
        //go to calculate;
    }
}

-(void)orderSubmit
{
    
}

@end
