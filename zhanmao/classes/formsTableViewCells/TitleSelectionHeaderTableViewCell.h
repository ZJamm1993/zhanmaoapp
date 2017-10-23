//
//  TitleSelectionHeaderTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleSelectionHeaderTableViewCell : FormBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textField;

@end
