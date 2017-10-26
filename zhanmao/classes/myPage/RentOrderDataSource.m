//
//  RentOrderDataSource.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderDataSource.h"

@implementation RentOrderDataSource

+(NSArray*)allOrders
{
    static NSMutableArray* alls;
    if (alls.count==0) {
        alls=[NSMutableArray array];
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
            [alls addObject:mo];
        }
    }
    return alls;
}

+(NSArray*)rentOrderDatasWithType:(RentOrderType)type
{
    NSArray* all=[self allOrders];
    if (type==RentOrderTypeAll)
    {
        return all;
    }
    else
    {
        NSMutableArray* ne=[NSMutableArray array];
        for (RentOrderModel* mo in all) {
            if (mo.type==type) {
                [ne addObject:mo];
            }
        }
        return ne;
    }
}

@end
