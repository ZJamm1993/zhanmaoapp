//
//  CorneredImageView.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CorneredImageView.h"

@implementation CorneredImageView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=3;
    self.layer.borderColor=gray_8.CGColor;
    self.layer.borderWidth=1/[[UIScreen mainScreen]scale];
}

@end
