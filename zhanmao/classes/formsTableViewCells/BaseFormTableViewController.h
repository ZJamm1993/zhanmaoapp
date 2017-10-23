//
//  BaseFormTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseViewController.h"
#import "TitleTextFieldTableViewCell.h"
#import "TitleTextViewTableViewCell.h"
#import "TitleSelectionHeaderTableViewCell.h"
#import "TitleSelectionItemTableViewCell.h"

@interface BaseFormTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,FormBaseTableViewCellDelegate>

@property (nonatomic,strong) UITableView* tableView;

@end
