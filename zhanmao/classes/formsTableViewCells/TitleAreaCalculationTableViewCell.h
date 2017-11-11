//
//  TitleAreaCalculationTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleAreaCalculationTableViewCell : FormBaseTableViewCell

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titles;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *units;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UIView *bottomResultView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomResultViewHeight;

@end
