//
//  ExhibitionLargeCardTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitionLargeCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;

-(void)setCornerRadius;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
