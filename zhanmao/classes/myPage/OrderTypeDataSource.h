//
//  OrderTypeDataSource.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderTypeBaseModel.h"

@interface OrderTypeDataSource : NSObject

+(NSArray*)rentOrderDatasWithType:(RentOrderType)type;

@end
