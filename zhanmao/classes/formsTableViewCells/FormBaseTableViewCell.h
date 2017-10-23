//
//  FormBaseTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FormBaseTableViewCell;

@protocol FormBaseTableViewCellDelegate <NSObject>

@optional
-(void)formBaseTableViewCellWillBeginEditing:(FormBaseTableViewCell*)cell;

@end

@interface FormBaseTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) NSString* keyPath;

@property (nonatomic,weak) id<FormBaseTableViewCellDelegate>delegate;

@end
