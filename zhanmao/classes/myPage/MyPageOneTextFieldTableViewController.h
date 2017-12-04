//
//  MyPageOneTextFieldTableViewController.h
//  zhanmao
//
//  Created by jam on 2017/12/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "MyPageCellModel.h"

@class MyPageOneTextFieldTableViewController;

@protocol MyPageOneTextFieldTableViewControllerDelegate <NSObject>

-(void)myPageOneTextFieldTableViewController:(MyPageOneTextFieldTableViewController*)viewController didFinishTexting:(NSString*)text;

@end

@interface MyPageOneTextFieldTableViewController : BaseTableViewController

@property (nonatomic,assign) NSInteger editingType;
@property (nonatomic,strong) NSString* presetString;

@property (nonatomic,weak) MyPageCellModel* cellModel;

@property (nonatomic,weak) id<MyPageOneTextFieldTableViewControllerDelegate>delegate;

@end
