//
//  RentActionEditView.h
//  zhanmao
//
//  Created by bangju on 2017/11/7.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RentModel.h"
#import "ZZStepper.h"

@protocol RentActionEditViewDelegate <NSObject>

@optional
-(void)rentActionEditViewAddToRentCart:(RentCartModel*)cartModel;
-(void)rentActionEditViewRentNow:(RentCartModel*)cartModel;

@end

@interface RentActionEditView : UIView

@property (weak, nonatomic) IBOutlet UIButton *xButton;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UIButton *rentNowButton;

@property (weak, nonatomic) IBOutlet UIView *darkBg;
@property (weak, nonatomic) IBOutlet UIView *cartBg;

@property (nonatomic,strong) RentCartModel* cartModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet CorneredImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *rentLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountRentLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalRentLabel;

+(instancetype)defaultView;

-(void)show;
-(void)hide;

-(void)showWithBottomInset:(CGFloat)bottomInset;

@property (nonatomic,weak) id<RentActionEditViewDelegate> delegate;

@end
