//
//  CleanOrderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *stateTitle;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@property (weak, nonatomic) IBOutlet UILabel *baseFee;
@property (weak, nonatomic) IBOutlet UILabel *otherFee;
@property (weak, nonatomic) IBOutlet UILabel *totalFee;

@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *grayButton;

@end
