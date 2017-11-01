//
//  RentCartEditToolBar.h
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentCartEditToolBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIView *moneyBg;
@property (weak, nonatomic) IBOutlet UILabel *rent;
@property (weak, nonatomic) IBOutlet UILabel *deposit;

@property (nonatomic,assign) BOOL editing;
@property (nonatomic,assign) BOOL seletedAll;
@property (nonatomic,assign) CGFloat rentValue;
@property (nonatomic,assign) CGFloat depositValue;

@end
