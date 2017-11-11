//
//  FormHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "BaseFormStepsModel.h"

@interface FormHttpTool : ZZHttpTool

+(void)getCustomTableListByType:(NSInteger)type success:(void (^)(BaseFormStepsModel* step))success failure:(void (^)(NSError *err))failure;

@end

/*
{
    code = 0,
    message = ok,
    state = success,
    data = {
        step1 = {
            title = 保洁,
            data = {
                data = [
                        [
                {
                    field = exhibition,
                    option = [
                              展馆1号,
                              展馆2号,
                              展馆3号,
                              展馆4号
                              ],
                    hint = 请选择展馆,
                    type = 31,
                    required = 1,
                    name = 展馆
                },
                {
                    field = exhibition,
                    option = [
                              展区1号,
                              展区2号,
                              展区3号,
                              展区4号
                              ],
                    hint = 请选择展区,
                    type = 31,
                    required = 1,
                    name = 展区
                },
                {
                    field = exhibition,
                    option = [
                              展位1号,
                              展位2号,
                              展位3号,
                              展位4号
                              ],
                    hint = 请选择展位,
                    type = 31,
                    required = 1,
                    name = 展位
                },
                {
                    field = date,
                    hint = 请选择服务时间,
                    type = 91,
                    required = 1,
                    name = 日期
                },
                {
                    field = other,
                    hint = 请输入电话,
                    type = 1,
                    required = 1,
                    name = 电话
                }
                         ],
                        [
                {
                    field = professor,
                    hint = 请选择套餐面积,
                    type = 1,
                    required = 1,
                    name = 套餐面积
                },
                {
                    field = scholar,
                    hint = 请选择套餐额外面积,
                    type = 1,
                    required = 1,
                    name = 套餐额外面积
                }
                         ]
                        ],
                description = 注: 请如实填写信息,一切以实际面积为准,超过后以10￥/M2补差价
            }
        }
    }
    }
*/
