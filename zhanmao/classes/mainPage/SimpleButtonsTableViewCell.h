//
//  SimpleButtonsTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleButtonModel;
@class SimpleButtonsTableViewCell;

@protocol SimpleButtonsTableViewCellDelegate <NSObject>

@optional
-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell*)cell didSelectedModel:(SimpleButtonModel*)model;

@end

@interface SimpleButtonsTableViewCell : BaseTableViewCell

+(CGFloat)heightWithButtonsCount:(NSInteger)count;

@property (nonatomic,strong) NSArray<SimpleButtonModel*>* buttons;
@property (nonatomic,weak) id<SimpleButtonsTableViewCellDelegate> delegate;

@end

@interface SimpleButtonModel : NSObject

@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* imageName;
@property (nonatomic,strong) NSString* identifier;

-(instancetype)initWithTitle:(NSString*)title imageName:(NSString*)imageName identifier:(NSString*)identifier;

@end
