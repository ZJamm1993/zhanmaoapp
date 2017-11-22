//
//  RentModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZModel.h"

@interface RentClass : BaseModel

@end

@interface RentProductModel : BaseModel

@end

@interface RentCartModel : ZZModel

@property (nonatomic,strong) RentProductModel* product;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger days;
@property (nonatomic,assign) BOOL selected;

@end
