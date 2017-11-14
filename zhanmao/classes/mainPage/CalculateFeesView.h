//
//  CalculateFeesView.h
//  zhanmao
//
//  Created by bangju on 2017/11/14.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateFeesView : UIView
@property (weak, nonatomic) IBOutlet UILabel *packageFee;
@property (weak, nonatomic) IBOutlet UILabel *otherFee;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end
