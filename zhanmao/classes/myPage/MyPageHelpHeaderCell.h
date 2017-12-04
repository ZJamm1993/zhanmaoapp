//
//  MyPageHelpHeaderCell.h
//  zhanmao
//
//  Created by jam on 2017/12/4.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "LinedTableViewCell.h"

@interface MyPageHelpHeaderCell : LinedTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLeft;
@property (weak, nonatomic) IBOutlet UILabel *titleRight;
@property (weak, nonatomic) IBOutlet UILabel *detailLeft;
@property (weak, nonatomic) IBOutlet UILabel *detailRight;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;

@end
