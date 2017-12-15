//
//  ZhantaiOrderDetailViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderDetailTableViewController.h"

@interface ZhantaiOrderDetailViewController : CustomOrderDetailTableViewController

@property (weak, nonatomic) IBOutlet UILabel *order_num;
@property (weak, nonatomic) IBOutlet UILabel *exhibitors;
@property (weak, nonatomic) IBOutlet UILabel *exhibition_name;
@property (weak, nonatomic) IBOutlet UILabel *hall_name;
@property (weak, nonatomic) IBOutlet UILabel *hall_child;
@property (weak, nonatomic) IBOutlet UILabel *booth_number;
@property (weak, nonatomic) IBOutlet UILabel *scalebooth_date;

@property (weak, nonatomic) IBOutlet UILabel *long_label;
@property (weak, nonatomic) IBOutlet UILabel *width;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *hall_area;
@property (weak, nonatomic) IBOutlet UILabel *ceiling_area;
@property (weak, nonatomic) IBOutlet UILabel *layers;
@property (weak, nonatomic) IBOutlet UILabel *ground;
@property (weak, nonatomic) IBOutlet UILabel *wall;
@property (weak, nonatomic) IBOutlet UILabel *lamps;
@property (weak, nonatomic) IBOutlet UILabel *led_screen;
@property (weak, nonatomic) IBOutlet UILabel *tv_count;

@property (weak, nonatomic) IBOutlet UILabel *style;
@property (weak, nonatomic) IBOutlet UILabel *type_label;
@property (weak, nonatomic) IBOutlet UILabel *furniture;

@property (weak, nonatomic) IBOutlet UILabel *art;
@property (weak, nonatomic) IBOutlet UILabel *claim;

@end
