//
//  RentOrderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTypeBaseModel.h"


@interface RentOrderTableViewCell : UITableViewCell

@property (nonatomic,strong) RentOrderModel* model;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *stateTitle;

@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *grayButton;

@end
