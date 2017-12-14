//
//  PayResultViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/6.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseViewController.h"
#import "ZZPayTool.h"

@interface PayResultViewController : BaseViewController

@property (nonatomic,assign) NSInteger payResultType;
@property (nonatomic,strong) UIViewController* orderDetailController;

@end
