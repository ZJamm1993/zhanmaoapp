//
//  InvoiceModel.h
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeBaseModel.h"

typedef NS_ENUM(NSInteger,InvoiceType)
{
    InvoiceTypeRent,
    InvoiceTypeClean,
};

@interface InvoiceModel : OrderTypeBaseModel



@end
