//
//  YaoyueOrderDetailViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "YaoyueOrderDetailViewController.h"

@interface YaoyueOrderDetailViewController ()

@end

@implementation YaoyueOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshCustomModel:(CustomOrderModel *)model
{
    NSDictionary* dic=model.dictionary;
    
    self.order_num.text=[dic valueForKey:@"order_num"];
    self.exhibition_name.text=[dic valueForKey:@"exhibition_name"];
    self.date.text=[dic valueForKey:@"date"];
    self.organizer.text=[dic valueForKey:@"organizer"];
    self.hall_name.text=[dic valueForKey:@"hall_name"];
    self.scale.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"scale"],@"m²"];
    self.type_label.text=[dic valueForKey:@"type"];
    self.nature.text=[dic valueForKey:@"nature"];
    
    self.buyers.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"buyers"],@"人"];
    self.enterprise.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"enterprise"],@"人"];
    self.company.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"company"],@"人"];
    self.materials.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"materials"],@"人"];
    self.public_label.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"public"],@"人"];
    self.professor.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"professor"],@"人"];
    self.scholar.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"scholar"],@"人"];
    self.authority.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"authority"],@"人"];
    self.other.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"other"],@"人"];
    
    self.system.on=[[dic valueForKey:@"system"]boolValue];
}

@end
