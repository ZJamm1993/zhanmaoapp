//
//  RentOrderDataSource.h
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RentOrderModel.h"



@interface RentOrderDataSource : NSObject


+(NSArray*)rentOrderDatasWithType:(RentOrderType)type;

@end
