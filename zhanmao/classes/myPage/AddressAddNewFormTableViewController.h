//
//  AddressAddNewFormTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/11/18.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseFormTableViewController.h"
#import "MyPageHttpTool.h"

#define AddressAddNewNotification @"AddressAddNewNotification"

@interface AddressAddNewFormTableViewController : BaseFormTableViewController

@property (nonatomic,strong) AddressModel* editAddress;

@end
