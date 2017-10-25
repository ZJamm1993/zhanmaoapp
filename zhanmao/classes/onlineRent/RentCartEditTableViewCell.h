//
//  RentCartEditTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZStepper.h"

@interface RentCartEditTableViewCell : UITableViewCell

//@property (nonatomic,assign) BOOL editing;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *normalBg;
@property (weak, nonatomic) IBOutlet UIView *editingBg;
@property (weak, nonatomic) IBOutlet ZZStepper *countStepper;
@property (weak, nonatomic) IBOutlet ZZStepper *dayStepper;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *rent;
//@property (weak, nonatomic) IBOutlet UILabel *deposit;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *days;

@end
