//
//  OrderTypeTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "OrderTypeBaseModel.h"
#import "OrderTypeDataSource.h"

@interface OrderTypeTableViewController : BaseTableViewController

@property (nonatomic,assign) NSInteger type;

-(void)orderStatusChanged:(OrderTypeBaseModel*)orderModel;

@end
