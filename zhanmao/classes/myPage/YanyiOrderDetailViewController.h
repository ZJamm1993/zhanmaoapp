//
//  YanyiOrderDetailViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderDetailTableViewController.h"

@interface YanyiOrderDetailViewController : CustomOrderDetailTableViewController

@property (weak, nonatomic) IBOutlet UILabel *order_num;
@property (weak, nonatomic) IBOutlet UILabel *organizer;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *performance_province_city_district;
@property (weak, nonatomic) IBOutlet UILabel *performance_address;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *days;

@property (weak, nonatomic) IBOutlet UILabel *long_label;
@property (weak, nonatomic) IBOutlet UILabel *width;
@property (weak, nonatomic) IBOutlet UILabel *high;
@property (weak, nonatomic) IBOutlet UILabel *stage_area;

@property (weak, nonatomic) IBOutlet UILabel *wall;
@property (weak, nonatomic) IBOutlet UILabel *lamps;
@property (weak, nonatomic) IBOutlet UILabel *led_screen;
@property (weak, nonatomic) IBOutlet UILabel *tv_count;

@property (weak, nonatomic) IBOutlet UILabel *stage_height;
@property (weak, nonatomic) IBOutlet UILabel *wall_type;

@property (weak, nonatomic) IBOutlet UILabel *info_collect;
@property (weak, nonatomic) IBOutlet UILabel *furniture;

@property (weak, nonatomic) IBOutlet UILabel *meetings_count;

@property (weak, nonatomic) IBOutlet UISwitch *sound;
@property (weak, nonatomic) IBOutlet UISwitch *projector;
@property (weak, nonatomic) IBOutlet UISwitch *top_lighting;

@property (weak, nonatomic) IBOutlet UILabel *claim;

@end
