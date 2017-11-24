//
//  MainMsgModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger,MainMsgType)
{
    MainMsgTypeImageText=1,
    MainMsgTypeOnlyText=2,
};

@interface MainMsgModel : BaseModel

@property (nonatomic,assign) NSInteger type;

@end
