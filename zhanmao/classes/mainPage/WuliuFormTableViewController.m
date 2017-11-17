//
//  WuliuFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/10.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "WuliuFormTableViewController.h"

#import "TotalFeeView.h"

@interface WuliuFormTableViewController ()
{
    
    TotalFeeView* _totalFeeView;
}
@end

@implementation WuliuFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* headerIamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)];
    headerIamge.image=[UIImage imageNamed:@"chicken"];
    self.tableView.tableHeaderView=headerIamge;
    
    [self.bottomButton removeFromSuperview];
    _totalFeeView=[[[UINib nibWithNibName:@"TotalFeeView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    _totalFeeView.frame=self.bottomView.bounds;
    [_totalFeeView.submitButton addTarget:self action:@selector(orderSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_totalFeeView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } failure:^(NSError *err) {
        
    }];
    
}

-(NSInteger)type
{
    return 8;
}

-(void)orderSubmit
{
    
}


@end