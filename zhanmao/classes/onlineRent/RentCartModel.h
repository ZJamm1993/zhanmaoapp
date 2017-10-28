//
//  RentCartModel.h
//  zhanmao
//
//  Created by bangju on 2017/10/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RentProductModel.h"

@interface RentCartModel : NSObject

@property (nonatomic,strong) RentProductModel* product;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger days;
@property (nonatomic,assign) BOOL selected;

@end
