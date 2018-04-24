//
//  MoreExhiHeaderView.h
//  zhanmao
//
//  Created by ZJam on 2018/4/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreExhiHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic,copy) void(^areaClickBlock)(MoreExhiHeaderView* view);
@property (nonatomic,copy) void(^dateClickBlock)(MoreExhiHeaderView* view);

@end
