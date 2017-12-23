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

#import "PayOrderTableViewController.h"

@interface BaojieFormTableViewController ()
{
    CalculateFeesView* _smallFeeView;
    TotalFeeView* _totalFeeView;
}
@end

@implementation BaojieFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView* headerIamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)];
//    headerIamge.image=[UIImage imageNamed:@"chicken"];
//    self.tableView.tableHeaderView=headerIamge;
    // Do any additional setup after loading the view.
    
    [self.bottomButton removeFromSuperview];
    
    _totalFeeView=[[[UINib nibWithNibName:@"TotalFeeView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    CGRect fr=self.bottomView.bounds;
    fr.size.height=64;
    _totalFeeView.frame=fr;
    _totalFeeView.title.text=@"估计：";
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

#pragma mark calculate

-(void)valueChanged
{
    CGFloat professor=0;
    CGFloat other=0;
    NSArray* allModels=[self.formSteps allModels];
    for (BaseFormModel* model in allModels) {
        if([model.field isEqualToString:@"professor"])
        {
            professor=model.value.doubleValue;
//            model.value=[NSString stringWithFloat:professor headUnit:nil tailUnit:nil];
        }
        else if([model.field isEqualToString:@"other"])
        {
            other=model.value.doubleValue;
//            model.value=[NSString stringWithFloat:scholar headUnit:nil tailUnit:nil];
        }
    }
    
//    professor=professor*10;
    if (professor==0)
    {
        professor=0;
    }
    else if (professor<=36)
    {
        professor=388;
    }
    else if(professor<=54)
    {
        professor=588;
    }
    else if(professor<=81)
    {
        professor=788;
    }
    else if(professor<=108)
    {
        professor=888;
    }
    else if(professor<=200)
    {
        professor=professor*15;
    }
    else if(professor<=500)
    {
        professor=professor*13;
    }
    else
    {
        professor=professor*10;
    }
    
    other=other*10;
    _smallFeeView.packageFee.text=[NSString stringWithFloat:professor headUnit:@"¥" tailUnit:nil];
    _smallFeeView.otherFee.text=[NSString stringWithFloat:other headUnit:@"¥" tailUnit:nil];
    
    _totalFeeView.feeLabe.text=[NSString stringWithFloat:professor+other headUnit:@"¥" tailUnit:nil];
}

#pragma mark submit handler

-(void)orderSubmit
{
    [self checkAndAction];
}

-(BOOL)shouldHandlePayOrder:(PayOrderModel *)payOrder
{
    if (payOrder.idd.length>0) {
        PayOrderTableViewController* pay=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"PayOrderTableViewController"];
        pay.orderModel=payOrder;
        pay.orderType=PayOrderTypeClean;
        [self.navigationController pushViewController:pay animated:YES];
        [self.navigationController removeViewController:self];
        return YES;
    }
    return NO;
}

@end
