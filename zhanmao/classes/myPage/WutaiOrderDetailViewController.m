//
//  WutaiOrderDetailViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "WutaiOrderDetailViewController.h"

@interface WutaiOrderDetailViewController ()

@end

@implementation WutaiOrderDetailViewController

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
    NSDictionary * dic=model.dictionary;
    
    self.order_num.text=[dic valueForKey:@"order_num"];
    self.organizer.text=[dic valueForKey:@"organizer"];
    self.name.text=[dic valueForKey:@"name"];
    self.region.text=[dic valueForKey:@"region"];
    self.stage_province_city_district.text=[NSString stringWithFormat:@"%@%@%@",[dic valueForKey:@"stage_province"],[dic valueForKey:@"stage_city"],[dic valueForKey:@"stage_district"]];
    self.stage_address.text=[dic valueForKey:@"stage_address"];
    self.date.text=[[dic valueForKey:@"date"]dateString];
    self.days.text=[dic valueForKey:@"days"];
    
    self.long_label.text=[dic valueForKey:@"long"];
    self.width.text=[dic valueForKey:@"width"];
    self.high.text=[dic valueForKey:@"high"];
    self.stage_area.text=[[dic valueForKey:@"stage_area"]stringAppendingUnit:UnitStringSquareMeter];
    
    self.wall.text=[dic valueForKey:@"wall"];
    self.lamps.text=[dic valueForKey:@"lamps"];
    self.led_screen.text=[dic valueForKey:@"led_screen"];
    self.tv_count.text=[dic valueForKey:@"tv_count"];
    
    self.stage_height.text=[dic valueForKey:@"stage_height"];
    self.wall_type.text=[dic valueForKey:@"wall_type"];
    
    self.furniture.text=[dic valueForKey:@"furniture"];
    
    self.meetings_count.text=[dic valueForKey:@"meetings_count"];
    
    self.sound.on=[[dic valueForKey:@"sound"]boolValue];
    self.projector.on=[[dic valueForKey:@"projector"]boolValue];
    
    self.claim.text=[dic valueForKey:@"claim"];
}

@end
