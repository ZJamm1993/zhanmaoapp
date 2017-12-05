//
//  MyPageCellModel.h
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MyPageCellModelType)
{
    MyPageCellModelTypeText,
    MyPageCellModelTypeImage,
    MyPageCellModelTypePhone,
    MyPageCellModelTypeMail,
};

@interface MyPageCellModel : NSObject

@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* image;
@property (nonatomic,strong) NSString* detail;
@property (nonatomic,strong) NSString* identifier;
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) BOOL selected;

+(instancetype)modelWithTitle:(NSString*)title image:(NSString*)image detail:(NSString*)detail identifier:(NSString*)identifier;
+(instancetype)modelWithTitle:(NSString*)title image:(NSString*)image detail:(NSString*)detail identifier:(NSString*)identifier type:(NSInteger)type;

@end
