//
//  MainPageHeaderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleButtonsTableViewCell.h"

@interface MyPageHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cardBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *headImageBg;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

-(void)setButtons:(NSArray<SimpleButtonModel*>*)buttons;
-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate;

@end
