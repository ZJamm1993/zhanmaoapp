//
//  ExhibitionCollectionViewCell.h
//  zhanmao
//
//  Created by ZJam on 2018/4/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitionCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end
