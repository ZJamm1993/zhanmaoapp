//
//  InvoiceModel.m
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "InvoiceModel.h"

@implementation InvoiceModel

+(NSString*)controllerTitleForType:(NSInteger)type
{
    if (type==InvoiceTypeRent) {
        return @"租赁";
    }
    else if(type==InvoiceTypeClean) {
        return @"保洁";
    }
    return @"";
}

@end
