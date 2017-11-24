//
//  ProductSmallTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/10/18.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageSmallTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CorneredImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *readCount;
@property (weak, nonatomic) IBOutlet UIView *readCountView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;

@property (nonatomic,assign) BOOL showReadCount;
@property (nonatomic,assign) BOOL showImage;

@end
