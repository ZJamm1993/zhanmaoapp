//
//  CustomOrderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/8.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *titleValue;
@property (weak, nonatomic) IBOutlet UILabel *idName;
@property (weak, nonatomic) IBOutlet UILabel *customOrderId;
@property (weak, nonatomic) IBOutlet UILabel *dateName;
@property (weak, nonatomic) IBOutlet UILabel *customOrderDate;
@property (weak, nonatomic) IBOutlet UILabel *UnitName;
@property (weak, nonatomic) IBOutlet UILabel *customOrderUnit;

@property (weak, nonatomic) IBOutlet UILabel *cancelLabel;
@property (nonatomic,assign) BOOL canceled;

@end
