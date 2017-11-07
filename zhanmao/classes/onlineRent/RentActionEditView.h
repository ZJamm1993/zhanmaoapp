//
//  RentActionEditView.h
//  zhanmao
//
//  Created by bangju on 2017/11/7.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RentActionEditViewDelegate <NSObject>

@optional

@end

@interface RentActionEditView : UIView

@property (weak, nonatomic) IBOutlet UIButton *xButton;
@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UIButton *rentNowButton;

@property (weak, nonatomic) IBOutlet UIView *darkBg;
@property (weak, nonatomic) IBOutlet UIView *cartBg;

+(instancetype)defaultView;

-(void)show;
-(void)hide;

@property (nonatomic,weak) id<RentActionEditViewDelegate> delegate;

@end
