//
//  MainPageHeaderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageHeaderTableViewCell.h"

@interface MyPageHeaderTableViewCell()

@property (weak, nonatomic) IBOutlet SimpleButtonsTableViewCell *buttonsCell;

@end

@implementation MyPageHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    
    self.personalBg.backgroundColor=_mainColor;
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.cardBg.layer.cornerRadius=8;
    self.cardBg.layer.shadowColor=[UIColor grayColor].CGColor;
    self.cardBg.layer.shadowOffset=CGSizeZero;
    self.cardBg.layer.shadowRadius=2;
    self.cardBg.layer.shadowOpacity=0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImageBg.layer.cornerRadius=self.headImageBg.frame.size.width/2;
    self.headImageView.layer.cornerRadius=self.headImageView.frame.size.width/2;
    
    self.headImageView.layer.masksToBounds=YES;
    self.headImageBg.layer.masksToBounds=YES;
}

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    self.buttonsCell.buttons=buttons;
    CGFloat he=[SimpleButtonsTableViewCell heightWithButtonsCount:buttons.count];
    self.cardHeightConstraint.constant=he;
}

-(void)setSimpleButtonsCellDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate
{
    self.buttonsCell.delegate=delegate;
}

- (IBAction)settingButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(myPageHeaderTableViewCellSettingButtonClicked:)]) {
        [self.delegate myPageHeaderTableViewCellSettingButtonClicked:self];
    }
}

- (IBAction)headButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(myPageHeaderTableViewCellPersonalButtonClicked:)]) {
        [self.delegate myPageHeaderTableViewCellPersonalButtonClicked:self];
    }
}

@end
