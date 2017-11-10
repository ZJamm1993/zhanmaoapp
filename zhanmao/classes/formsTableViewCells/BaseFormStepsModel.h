//
//  BaseFormStepsModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZModel.h"
#import "BaseFormStepsModel.h"

typedef NS_ENUM(NSUInteger,BaseFormType)
{
    BaseFormTypeUnknown=0,
    BaseFormTypeNormal=1,
//    BaseFormTypeMutiChoice=3,
    BaseFormTypeTimePicker=9,
    BaseFormTypeNormalUnit=11,
    BaseFormTypeLargeField=12,
    BaseFormTypeSingleChoice=3,//1,
};

@interface BaseFormModel : ZZModel

@property (nonatomic,assign) BaseFormType type;
@property (nonatomic,assign) BOOL required; //allowed null or not
@property (nonatomic,strong) NSString* name; //title for cell
@property (nonatomic,strong) NSString* field; //key for params
@property (nonatomic,strong) NSString* hint; //place holder
@property (nonatomic,strong) NSString* value; //value for params
@property (nonatomic,strong) NSString* unit; //unit
@property (nonatomic,strong) NSArray* option; //option

@end

@interface BaseFormSection : ZZModel

@property (nonatomic,strong) NSArray<BaseFormModel*>* models;

@end

@interface BaseFormStep : ZZModel

@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSArray<BaseFormSection*>* sections;

@end

@interface BaseFormStepsModel : ZZModel

@property (nonatomic,strong) NSArray<BaseFormStep*>* steps;

-(NSString*)warningStringForStep:(NSInteger)step;

-(NSDictionary*)parameters;

@end


/*
{
    "code": 0,
    "message": "ok",
    "state": "success",
    "data": {
        "step1": {
            "title": "主场",
            "data": [
                     [
                      {
                          "name": "展会名称",
                          "field": "name",
                          "hint": "请输入展会名称",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "展会日期",
                          "field": "time",
                          "hint": "请选择时间",
                          "type": "9",
                          "required": "1"
                      },
                      {
                          "name": "承办单位",
                          "field": "organizer",
                          "hint": "请输入展会名称",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "展会编号",
                          "field": "numer",
                          "hint": "请输入展会名称",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "展会规模",
                          "field": "scale",
                          "hint": "请输入展会规模",
                          "unit": "m2",
                          "type": "11",
                          "required": "1"
                      },
                      {
                          "name": "天数",
                          "field": "days",
                          "hint": "请输入展会天数",
                          "unit": "天",
                          "type": "11",
                          "required": "1"
                      },
                      {
                          "name": "展位个数",
                          "field": "booth_count",
                          "hint": "请输入展位个数 例如:5",
                          "type": "1",
                          "required": "1"
                      }
                      ],
                     [
                      {
                          "name": "主场信息采集",
                          "field": "info_collect",
                          "type": "3",
                          "option": [
                                     "全部",
                                     "会议服务",
                                     "拱门广告",
                                     "塑料"
                                     ],
                          "required": "1"
                      },
                      {
                          "name": "定制要求(非必填)",
                          "field": "",
                          "hint": "请输入定制要求...",
                          "type": "12",
                          "required": "0"
                      }
                      ]
                     ]
        },
        "step2": {
            "title": "联系人",
            "data": [
                     [
                      {
                          "name": "联系人",
                          "field": "addressee",
                          "hint": "请输入联系人",
                          "type": "1",
                          "required": "0"
                      },
                      {
                          "name": "办公电话",
                          "field": "o_phone",
                          "hint": "请输入办公电话",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "移动手机",
                          "field": "m_phone",
                          "hint": "请输入移动手机",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "邮箱",
                          "field": "email",
                          "hint": "请输入邮箱地址",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "省份",
                          "field": "province",
                          "hint": "请输入省份",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "市",
                          "field": "city",
                          "hint": "请输入市",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "区",
                          "field": "district",
                          "hint": "请输入区",
                          "type": "1",
                          "required": "1"
                      },
                      {
                          "name": "地址",
                          "field": "address",
                          "hint": "请输入联系地址",
                          "type": "1",
                          "required": "1"
                      }
                      ]
                     ]
        }
    }
}
*/
