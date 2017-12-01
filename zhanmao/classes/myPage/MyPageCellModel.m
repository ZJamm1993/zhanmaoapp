//
//  MyPageCellModel.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageCellModel.h"

@implementation MyPageCellModel

+(instancetype)modelWithTitle:(NSString *)title image:(NSString *)image detail:(NSString *)detail identifier:(NSString *)identifier
{
    MyPageCellModel* m=[[MyPageCellModel alloc]init];
    m.title=title;
    m.image=image;
    m.detail=detail;
    m.identifier=identifier;
    return m;
}

+(instancetype)modelWithTitle:(NSString *)title image:(NSString *)image detail:(NSString *)detail identifier:(NSString *)identifier type:(NSInteger)type
{
    MyPageCellModel* mm=[self modelWithTitle:title image:image detail:detail identifier:identifier];
    mm.type=type;
    return mm;
}

@end
