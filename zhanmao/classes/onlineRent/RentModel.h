//
//  RentModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZModel.h"

#define RentGoodPriceUnit @"/周期(4天)"

@interface RentClass : BaseModel

@end

@interface RentProductModel : BaseModel

@property (nonatomic,strong) NSString* goods_id;
@property (nonatomic,assign) CGFloat rent;
@property (nonatomic,assign) CGFloat rent_o;
@property (nonatomic,assign) CGFloat deposit;

@end

@interface RentCartModel : ZZModel

@property (nonatomic,strong) RentProductModel* product;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger days;
@property (nonatomic,assign) BOOL selected;

@end


