//
//  FormBaseTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFormStepsModel.h"

@class FormBaseTableViewCell;

@protocol FormBaseTableViewCellDelegate <NSObject>

@optional
-(void)formBaseTableViewCellWillBeginEditing:(FormBaseTableViewCell*)cell;
-(void)formBaseTableViewCellValueChanged:(FormBaseTableViewCell*)cell;
-(void)formBaseTableViewCell:(FormBaseTableViewCell*)cell shouldPushViewController:(UIViewController*)viewController;

@end

@interface FormBaseTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>

//@property (nonatomic,strong) NSString* keyPath;

@property (nonatomic,weak) id<FormBaseTableViewCellDelegate>delegate;

@property (nonatomic,strong) BaseFormModel* model;

-(void)reloadModel;

-(void)valueChanged;

@end
