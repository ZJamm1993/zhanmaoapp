//
//  CustomOrderDetailTableViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeDetailTableViewController.h"
#import "OrderDetailStatusComplexStyleCell.h"

@interface CustomOrderDetailTableViewController : OrderTypeDetailTableViewController

@property (nonatomic,strong) CustomOrderModel* customModel;
@property (weak, nonatomic) IBOutlet OrderDetailStatusComplexStyleCell *headerStatusCell;

-(void)refreshCustomModel:(CustomOrderModel*)model;

//some same properties

@property (weak, nonatomic) IBOutlet UILabel *addressee;
@property (weak, nonatomic) IBOutlet UILabel *o_phone;
@property (weak, nonatomic) IBOutlet UILabel *m_phone;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *province_city_district;
@property (weak, nonatomic) IBOutlet UILabel *address;


@end
