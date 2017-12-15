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
#import "TitleDescriptionTableViewCell.h"
#import "TitleAreaCalculationTableViewCell.h"
#import "TitleSwitchTableViewCell.h"
#import "TitleAddressSeletectTableViewCell.h"
#import "TitleNoneImageTableViewCell.h"
#import "TitleDoubleSelectionTableViewCell.h"

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

@property (nonatomic,strong) NSDictionary* prefixValues;

-(void)loadFormJson; //set formSteps after loading

-(void)valueChanged; //do something such calculating

-(void)checkAndAction; //check models and submitToserver if OK

-(void)submitToServer; //can be overwrite

-(BOOL)shouldHandlePayOrder:(PayOrderModel*)payOrder;

+(NSString*)cellNibNameForFormType:(BaseFormType)type;

@end
