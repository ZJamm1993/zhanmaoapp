//
//  ExhibitionLargeRectTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitionLargeRectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *detailTitleBg;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;

@end
