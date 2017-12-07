//
//  OrderDetailAddressCell.h
//  zhanmao
//
//  Created by jam on 2017/12/7.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "LinedTableViewCell.h"

@interface OrderDetailAddressCell : LinedTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end
