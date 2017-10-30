//
//  MyInvoiceTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInvoiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cardBg;
@property (weak, nonatomic) IBOutlet UILabel *serialNumber;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;
@property (weak, nonatomic) IBOutlet UILabel *sumOfMoney;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@end
