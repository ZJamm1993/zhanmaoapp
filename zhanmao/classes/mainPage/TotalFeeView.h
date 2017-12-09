//
//  TotalFeeView.h
//  zhanmao
//
//  Created by bangju on 2017/11/14.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalFeeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *feeLabe;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *grayButton;

@property (nonatomic,assign) BOOL showingGrayButton;

@end
