//
//  TransportOrderModel.h
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TransportOrderType)
{
    TransportOrderTypeNow,
    TransportOrderTypeHistory,
};

@interface TransportOrderModel : NSObject

+(NSString*)controllerTitleForType:(TransportOrderType)type;

@end
