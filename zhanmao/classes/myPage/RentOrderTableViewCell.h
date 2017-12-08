//
//  RentOrderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTypeBaseModel.h"

@class RentOrderTableViewCell;

@protocol RentOrderTableViewCellDelegate <NSObject>

-(void)rentOrderTableViewCellActionButtonClick:(RentOrderTableViewCell*)cell;

@end

@interface RentOrderTableViewCell : LinedTableViewCell

@property (nonatomic,strong) RentOrderModel* orderModel;
@property (nonatomic,strong) RentCartModel* cartModel;

@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *stateTitle;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet CorneredImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *rent;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *deposit;

@property (weak, nonatomic) IBOutlet UILabel *days;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *grayButton;

@property (nonatomic,weak) id<RentOrderTableViewCellDelegate>delegate;

@end
