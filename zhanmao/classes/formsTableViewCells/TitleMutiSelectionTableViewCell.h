//
//  TitleMutiSelectionTableViewCell.h
//  zhanmao
//
//  Created by bangju on 2017/11/10.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MutiSelectionButtonsView;

@protocol  MutiSelectionButtonsViewDelegate<NSObject>

@optional
-(void)mutiSelectionButtonsViewValueDidChanged:(NSString*)value;

@end

@interface TitleMutiSelectionTableViewCell : FormBaseTableViewCell<MutiSelectionButtonsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet MutiSelectionButtonsView *selectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectionViewHeight;

@end



@interface MutiSelectionButtonsView : UIView

@property (nonatomic,strong) NSArray* titles;
@property (nonatomic,strong) NSMutableArray* selectedTitles;
@property (nonatomic,weak) id<MutiSelectionButtonsViewDelegate>delegate;

+(CGFloat)heightForItemCount:(NSInteger)count;

@end
