//
//  CustomOrderDetailTableViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeDetailTableViewController.h"

@interface CustomOrderDetailTableViewController : OrderTypeDetailTableViewController

@property (nonatomic,strong) CustomOrderModel* customModel;

-(void)refreshCustomModel:(CustomOrderModel*)model;

@end
