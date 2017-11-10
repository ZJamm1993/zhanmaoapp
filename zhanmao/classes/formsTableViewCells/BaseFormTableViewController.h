//
//  BaseFormTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseViewController.h"

#import "FormBaseTableViewCell.h"

#import "TitleTextFieldTableViewCell.h"
#import "TitleTextViewTableViewCell.h"
#import "TitleSingleSelectionTableViewCell.h"
#import "TitleMutiSelectionTableViewCell.h"

#import "FormHttpTool.h"

@interface BaseFormTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,FormBaseTableViewCellDelegate>

@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) UIView* bottomView;
@property (nonatomic,strong) UIButton* bottomButton;
@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger stepInteger;
@property (nonatomic,strong) BaseFormStep* currentStep;
@property (nonatomic,strong) BaseFormStepsModel* formSteps;

-(void)loadFormJson;

@end
