//
//  MainPageHeaderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleButtonsTableViewCell.h"

@class MyPageHeaderTableViewCell;

@protocol MyPageHeaderTableViewCellDelegate <NSObject>

@optional
-(void)myPageHeaderTableViewCellSettingButtonClicked:(MyPageHeaderTableViewCell*)cell;
-(void)myPageHeaderTableViewCellPersonalButtonClicked:(MyPageHeaderTableViewCell*)cell;

@end

@interface MyPageHeaderTableViewCell : UITableViewCell

@property (weak, nonatomic) id<MyPageHeaderTableViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *cardBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *headImageBg;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIView *personalBg;

@property (weak, nonatomic) IBOutlet UIImageView *loginBgImage;
@property (weak, nonatomic) IBOutlet UIImageView *loginBgBlurImage;
@property (weak, nonatomic) IBOutlet UIView *loginBg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBgTopContraint;
@property (weak, nonatomic) IBOutlet UIView *loginBlurBg;

-(void)setButtons:(NSArray<SimpleButtonModel*>*)buttons;
-(void)setSimpleButtonsCellDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate;

@end
