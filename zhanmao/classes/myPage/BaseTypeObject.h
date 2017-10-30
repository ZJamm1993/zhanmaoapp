//
//  BaseTypeObject.h
//  zhanmao
//
//  Created by bangju on 2017/10/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTypeObject : NSObject

@property (nonatomic,assign) NSInteger type;

+(NSString*)controllerTitleForType:(NSInteger)type;

+(NSString*)cellTitleForType:(NSInteger)type;

@end
