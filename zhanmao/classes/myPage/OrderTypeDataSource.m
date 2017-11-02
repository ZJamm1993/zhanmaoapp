//
//  OrderTypeDataSource.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeDataSource.h"

@implementation OrderTypeDataSource

+(NSArray*)rentOrderDatasWithType:(RentOrderType)type
{
    static NSMutableArray* allsRentOrders;
    if (allsRentOrders.count==0) {
        allsRentOrders=[NSMutableArray array];
        for (NSInteger i=0; i<50; i++) {
            RentOrderModel* mo=[[RentOrderModel alloc]init];
            mo.title=[NSString stringWithFormat:@"%@%ld",@"商品",(long)i];
            int ra=arc4random()%4;
            if (ra==0) {
                mo.type=RentOrderTypeNotPaid;
            }
            else if(ra==1)
            {
                mo.type=RentOrderTypeNotSigned;
            }
            else if(ra==2)
            {
                mo.type=RentOrderTypeNotReturned;
            }
            else
            {
                mo.type=RentOrderTypeFinished;
            }
            [allsRentOrders addObject:mo];
        }
    }
    
    if (type==RentOrderTypeAll)
    {
        return allsRentOrders;
    }
    else
    {
        NSMutableArray* ne=[NSMutableArray array];
        for (RentOrderModel* mo in allsRentOrders) {
            if (mo.type==type) {
                [ne addObject:mo];
            }
        }
        return ne;
    }
}

@end
