//
//  PhotoSliderView.h
//  PhotoSliderView
//
//  Created by bangju on 2017/9/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoSliderViewDelegate<NSObject>

@optional
-(void)photoSliderViewDidSinglePress:(UIView*)view;
-(void)photoSliderViewDidLongPress:(UIView *)view;
@end

@interface PhotoSliderView : UIView

/*
 *
 UIImages;
 */
@property (nonatomic,strong) NSArray* images;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,weak) id<PhotoSliderViewDelegate>delegate;

@end

@interface PhotoSliderViewController : UIViewController

@property (nonatomic,strong) NSArray* images;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,copy) void(^longPressBlock)(UIImage* image);

+(UINavigationController*)navgationControllerWithPhotoSlider:(void(^)(PhotoSliderViewController* sliderController))configureBlock;



@end
