//
//  ExhibitionLargeCardTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionLargeCardTableViewCell.h"
#import "ExhibitionCollectionViewCell.h"

@implementation ExhibitionLargeCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.bgView.layer.cornerRadius=4;
//    self.bgView.layer.borderColor=gray_8.CGColor;
//    self.bgView.layer.borderWidth=0.5;
//    self.bgView.clipsToBounds=YES;
//    self.bgView.layer.masksToBounds=YES;
    
    if (self.collectionView) {
        [self.collectionView registerNib:[UINib nibWithNibName:@"ExhibitionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCornerRadius
{
//    NSLog(@"%@",NSStringFromCGRect(self.bgView.bounds));
//    
//    CGRect bous=self.bgView.bounds;
//    bous.size.width=[[UIScreen mainScreen]bounds].size.width-16;
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = bous;
//    
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.frame = bous;
//    borderLayer.lineWidth = 1.f;
//    borderLayer.strokeColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    borderLayer.fillColor = [UIColor clearColor].CGColor;
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bous cornerRadius:4];
//    maskLayer.path = bezierPath.CGPath;
//    borderLayer.path = bezierPath.CGPath;
//    
//    [self.bgView.layer insertSublayer:borderLayer atIndex:0];
//    [self.bgView.layer setMask:maskLayer];
    
}

//-(void)layoutSubviews
//{
////    [super layoutSubviews];
////    [self setCornerRadius];
//}

-(void)setExhibitionModels:(NSArray *)exhibitionModels
{
    _exhibitionModels=exhibitionModels;
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 3;
    return self.exhibitionModels.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    ExhibitionModel* mo=[self.exhibitionModels objectAtIndex:indexPath.row];
    [cell.image setImageUrl:[ZZUrlTool fullUrlWithTail:mo.thumb]];
    cell.title.text=mo.exhibition_name;
    cell.subtitle.text=[NSString stringWithFormat:@"%@-%@",[[mo.start_date componentsSeparatedByString:@" "]firstObject],[[mo.end_date componentsSeparatedByString:@" "]firstObject]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat w=(collectionView.frame.size.width-collectionViewLayout.minimumInteritemSpacing)/2;
    CGFloat h=w/343*209+60;
    return CGSizeMake(w, h);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionModel* mo=[self.exhibitionModels objectAtIndex:indexPath.row];
    if (self.collectionViewDidSelectBlock) {
        self.collectionViewDidSelectBlock(mo);
    }
}

@end
