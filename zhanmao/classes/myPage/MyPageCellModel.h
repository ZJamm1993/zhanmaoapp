//
//  MyPageCellModel.h
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPageCellModel : NSObject

@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* image;
@property (nonatomic,strong) NSString* detail;
@property (nonatomic,strong) NSString* identifier;

+(instancetype)modelWithTitle:(NSString*)title image:(NSString*)image detail:(NSString*)detail identifier:(NSString*)identifier;

@end
