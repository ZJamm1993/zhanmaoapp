//
//  YanyiOrderDetailViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "YanyiOrderDetailViewController.h"

@interface YanyiOrderDetailViewController ()

@end

@implementation YanyiOrderDetailViewController

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
    self.organizer.text=[dic valueForKey:@"organizer"];
    self.name.text=[dic valueForKey:@"name"];
    self.region.text=[dic valueForKey:@"region"];
    self.performance_province_city_district.text=[NSString stringWithFormat:@"%@%@%@",[dic valueForKey:@"performance_province"],[dic valueForKey:@"performance_city"],[dic valueForKey:@"performance_district"]];
    self.performance_address.text=[dic valueForKey:@"performance_address"];
    self.date.text=[dic valueForKey:@"date"];
    self.days.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"days"],@"天"];
    
    self.long_label.text=[dic valueForKey:@"long"];
    self.width.text=[dic valueForKey:@"width"];
    self.high.text=[dic valueForKey:@"high"];
    self.stage_area.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"stage_area"],@"m²"];
    
    self.wall.text=[dic valueForKey:@"wall"];
    self.lamps.text=[dic valueForKey:@"lamps"];
    self.led_screen.text=[dic valueForKey:@"led_screen"];
    self.tv_count.text=[dic valueForKey:@"tv_count"];
    
    self.stage_height.text=[NSString stringWithFormat:@"%@%@",[dic valueForKey:@"stage_height"],@"米"];
    self.wall_type.text=[dic valueForKey:@"wall_type"];
    
    self.info_collect.text=[dic valueForKey:@"info_collect"];
    
    self.furniture.text=[dic valueForKey:@"furniture"];
    
    self.meetings_count.text=[dic valueForKey:@"meetings_count"];
    
    self.sound.on=[[dic valueForKey:@"sound"]boolValue];
    self.projector.on=[[dic valueForKey:@"projector"]boolValue];
    self.top_lighting.on=[[dic valueForKey:@"top_lighting"]boolValue];
    
    self.claim.text=[dic valueForKey:@"claim"];
    
}

@end
