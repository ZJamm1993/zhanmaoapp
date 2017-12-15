//
//  OrderTypeDetailTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/11/21.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"
#import "OrderTypeBaseModel.h"
#import "OrderTypeDataSource.h"

@interface OrderTypeDetailTableViewController : BaseToolBarTableViewController

//@property (nonatomic,strong) OrderTypeBaseModel* model;

@property (nonatomic,assign) NSInteger type;

-(void)countingDown;

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel;

@end
