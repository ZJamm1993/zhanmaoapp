//
//  PayOrderTableViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/5.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"
#import "RentHttpTool.h"

typedef NS_ENUM(NSInteger,PayOrderType)
{
    PayOrderTypeRent=1,
    PayOrderTypeClean=2,
};

@interface PayOrderTableViewController : BaseToolBarTableViewController

@property (nonatomic,strong) PayOrderModel* orderModel;

@property (nonatomic,assign) NSInteger orderType;

@end
