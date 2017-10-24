//
//  MenuHeaderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuHeaderButtonModel : NSObject

@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign) BOOL ordered;
@property (nonatomic,assign) BOOL ascending;
@property (nonatomic,strong) NSString* title;

+(instancetype)modelWithTitle:(NSString*)title selected:(BOOL)selected ordered:(BOOL)ordered ascending:(BOOL)ascending;

@end

@class MenuHeaderTableViewCell;
@protocol MenuHeaderTableViewCellDelegate <NSObject>

@optional
-(void)menuHeaderTableViewCell:(MenuHeaderTableViewCell*)cell didChangeModels:(NSArray<MenuHeaderButtonModel*>*)models;

@end

@interface MenuHeaderTableViewCell : UITableViewHeaderFooterView

@property (nonatomic,strong) NSArray<MenuHeaderButtonModel*>* buttonModelArray;
@property (nonatomic,weak) id<MenuHeaderTableViewCellDelegate>delegate;

@end

