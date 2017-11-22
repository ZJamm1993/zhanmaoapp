//
//  ProductDetailViewController.h
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseToolBarTableViewController.h"
#import "RentHttpTool.h"

@interface ProductDetailViewController : BaseToolBarTableViewController

@property (nonatomic,strong) RentProductModel* goodModel;

@end
