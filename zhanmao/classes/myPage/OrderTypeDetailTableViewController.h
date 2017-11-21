//
//  OrderTypeDetailTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/11/21.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "OrderTypeBaseModel.h"
#import "OrderTypeDataSource.h"

@interface OrderTypeDetailTableViewController : BaseTableViewController

@property (nonatomic,strong) OrderTypeBaseModel* model;

@end
