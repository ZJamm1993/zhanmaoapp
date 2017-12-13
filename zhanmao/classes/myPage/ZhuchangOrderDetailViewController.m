//
//  ZhuchangOrderDetailViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZhuchangOrderDetailViewController.h"

@interface ZhuchangOrderDetailViewController ()

@end

@implementation ZhuchangOrderDetailViewController

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
    self.time.text=[[dic valueForKey:@"time"]dateString];
    self.organizer.text=[dic valueForKey:@"organizer"];
    self.hall_name.text=[dic valueForKey:@"hall_name"];
    self.hall_child.text=[dic valueForKey:@"hall_child"];
    self.numer.text=[dic valueForKey:@"numer"];
    self.scale.text=[[dic valueForKey:@"scale"]stringAppendingUnit:UnitStringSquareMeter];
    self.days.text=[[dic valueForKey:@"days"]stringAppendingUnit:@"天"];
    self.booth_count.text=[dic valueForKey:@"booth_count"];
    self.blanket_specification.text=[[dic valueForKey:@"blanket_specification"]stringAppendingUnit:@"米"];
    
    self.info_collect.text=[dic valueForKey:@"info_collect"];
    self.claim.text=[dic valueForKey:@"claim"];
}

@end
