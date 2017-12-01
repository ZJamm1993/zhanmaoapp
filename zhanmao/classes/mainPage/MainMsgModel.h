//
//  MainMsgModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,MainMsgShowType)
{
    MainMsgShowTypeImageText=1,
    MainMsgShowTypeOnlyText=2,
};

typedef NS_ENUM(NSInteger,MainMsgModelType)
{
    MainMsgModelTypeNews=1,
    MainMsgModelTypeProduct=2,
};

@interface MainMsgModel : BaseModel

@property (nonatomic,assign) NSInteger show_type;
@property (nonatomic,assign) NSInteger model_type;

@end
