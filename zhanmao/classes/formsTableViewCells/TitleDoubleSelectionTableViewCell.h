//
//  TitleDoubleSelectionTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleDoubleSelectionTableViewCell : FormBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;

@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;

@property (weak, nonatomic) IBOutlet UILabel *placeHolder1;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end
