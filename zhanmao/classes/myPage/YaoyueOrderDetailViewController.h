//
//  YaoyueOrderDetailViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CustomOrderDetailTableViewController.h"

@interface YaoyueOrderDetailViewController : CustomOrderDetailTableViewController

@property (weak, nonatomic) IBOutlet UILabel *order_num;
@property (weak, nonatomic) IBOutlet UILabel *exhibition_name;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *organizer;
@property (weak, nonatomic) IBOutlet UILabel *hall_name;
@property (weak, nonatomic) IBOutlet UILabel *scale;
@property (weak, nonatomic) IBOutlet UILabel *type_label;
@property (weak, nonatomic) IBOutlet UILabel *nature;

@property (weak, nonatomic) IBOutlet UILabel *buyers;
@property (weak, nonatomic) IBOutlet UILabel *enterprise;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *materials;
@property (weak, nonatomic) IBOutlet UILabel *public_label;

@property (weak, nonatomic) IBOutlet UILabel *professor;
@property (weak, nonatomic) IBOutlet UILabel *scholar;
@property (weak, nonatomic) IBOutlet UILabel *authority;
@property (weak, nonatomic) IBOutlet UILabel *other;

@property (weak, nonatomic) IBOutlet UISwitch *system;

@end
