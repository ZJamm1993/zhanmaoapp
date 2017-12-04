//
//  MainPageHeaderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MainPageHeaderTableViewCell.h"

@interface MainPageHeaderTableViewCell()

@property (weak, nonatomic) IBOutlet SimpleButtonsTableViewCell *buttonsCell;

@end

@implementation MainPageHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.cardBg.layer.cornerRadius=8;
    self.cardBg.layer.shadowColor=[UIColor grayColor].CGColor;
    self.cardBg.layer.shadowOffset=CGSizeZero;
    self.cardBg.layer.shadowRadius=2;
    self.cardBg.layer.shadowOpacity=0.5;
    
    self.titleBg.backgroundColor=_mainColor;
    self.colorBg.backgroundColor=_mainColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    self.buttonsCell.buttons=buttons;
    CGFloat he=[SimpleButtonsTableViewCell heightWithButtonsCount:buttons.count];
    self.cardHeightConstraint.constant=he;
}

-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate
{
    self.buttonsCell.delegate=delegate;
}

@end
