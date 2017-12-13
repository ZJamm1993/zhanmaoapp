//
//  ZhuchangOrderDetailViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderDetailTableViewController.h"

@interface ZhuchangOrderDetailViewController : CustomOrderDetailTableViewController

@property (weak, nonatomic) IBOutlet UILabel *order_num;
@property (weak, nonatomic) IBOutlet UILabel *exhibition_name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *organizer;
@property (weak, nonatomic) IBOutlet UILabel *hall_name;
@property (weak, nonatomic) IBOutlet UILabel *hall_child;
@property (weak, nonatomic) IBOutlet UILabel *numer;
@property (weak, nonatomic) IBOutlet UILabel *scale;
@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *booth_count;
@property (weak, nonatomic) IBOutlet UILabel *blanket_specification;

@property (weak, nonatomic) IBOutlet UILabel *info_collect;

@property (weak, nonatomic) IBOutlet UILabel *claim;

@end
