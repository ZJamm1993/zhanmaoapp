//
//  ExhibitionLargeCardTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExhibitionModel.h"

@interface ExhibitionLargeCardTableViewCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *bgView;

-(void)setCornerRadius;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *label;

//main page
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray* exhibitionModels;
@property (nonatomic,copy) void(^collectionViewDidSelectBlock)(ExhibitionModel* model);

@end
