//
//  ZhantingOrderDetailViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZhantingOrderDetailViewController.h"

@interface ZhantingOrderDetailViewController ()

@end

@implementation ZhantingOrderDetailViewController

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
    self.name.text=[dic valueForKey:@"name"];
    self.region.text=[dic valueForKey:@"region"];
    self.hall_name.text=[dic valueForKey:@"hall_name"];
    self.hall_child.text=[dic valueForKey:@"hall_child"];
    self.booth_number.text=[dic valueForKey:@"booth_number"];
    self.completion_date.text=[[dic valueForKey:@"completion_date"]dateString];
    
    self.long_label.text=[dic valueForKey:@"long"];
    self.width.text=[dic valueForKey:@"width"];
    self.high.text=[dic valueForKey:@"high"];
    self.hall_area.text=[[dic valueForKey:@"hall_area"]stringAppendingUnit:UnitStringSquareMeter];
    self.layers.text=[dic valueForKey:@"layers"];
    self.ground.text=[dic valueForKey:@"ground"];
    self.wall.text=[dic valueForKey:@"wall"];
    self.lamps.text=[dic valueForKey:@"lamps"];
    self.led_screen.text=[dic valueForKey:@"led_screen"];
    self.touch_screen.text=[dic valueForKey:@"touch_screen"];
    self.style.text=[dic valueForKey:@"style"];
    self.furniture.text=[dic valueForKey:@"furniture"];
    self.art.text=[dic valueForKey:@"art"];
    self.claim.text=[dic valueForKey:@"claim"];
}

@end
