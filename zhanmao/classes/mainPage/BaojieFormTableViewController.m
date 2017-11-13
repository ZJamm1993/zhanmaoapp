//
//  BaojieFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/10.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaojieFormTableViewController.h"

@interface BaojieFormTableViewController ()

@end

@implementation BaojieFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* headerIamge=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2)];
    headerIamge.image=[UIImage imageNamed:@"chicken"];
    self.tableView.tableHeaderView=headerIamge;
    // Do any additional setup after loading the view.
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
    return 7;
}



@end
