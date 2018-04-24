//
//  MoreExhiHeaderView.m
//  zhanmao
//
//  Created by ZJam on 2018/4/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MoreExhiHeaderView.h"

@implementation MoreExhiHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)areaClick:(id)sender {
    if (self.areaClickBlock) {
        self.areaClickBlock(self);
    }
}

- (IBAction)dateClick:(id)sender {
    if (self.dateClickBlock) {
        self.dateClickBlock(self);
    }
}

@end
