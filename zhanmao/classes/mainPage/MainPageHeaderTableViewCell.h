//
//  MainPageHeaderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleButtonsTableViewCell.h"

@interface MainPageHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cardBg;
@property (weak, nonatomic) IBOutlet UIView *titleBg;
@property (weak, nonatomic) IBOutlet UIView *colorBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardHeightConstraint;

-(void)setButtons:(NSArray<SimpleButtonModel*>*)buttons;
-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate;

@end
