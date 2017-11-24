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
    BaseFormTypeUnknown                         =0,
    
    BaseFormTypeNormal                          =1,
    BaseFormTypeNormalUnit                      =11,
    BaseFormTypeLargeField                      =12,
    
    BaseFormTypeMutiChoice                      =3,
    BaseFormTypeSingleChoice                    =31,
    BaseFormTypeSwitchCheck                     =32,
    
    BaseFormTypeImage                           =4,
    
    BaseFormTypeStepDescription                 =6,
    
    BaseFormTypeAddressSelection                =7,
    
    BaseFormTypeCalculateArea                   =8,
    BaseFormTypeProviceCityDistrict             =81,
    BaseFormTypeCalculateSize                   =82,
    
    BaseFormTypeDatePicker                      =9,
    BaseFormTypeDateTimePicker                  =91,
    BaseFormTypeDateScopePicker                 =92,
};

@interface BaseFormModel : ZZModel

@property (nonatomic,assign) BaseFormType type;

@property (nonatomic,assign) BOOL required; //allowed null or not
@property (nonatomic,strong) NSString* name; //title for cell
@property (nonatomic,strong) NSString* field; //key for params
@property (nonatomic,strong) NSString* hint; //place holder

@property (nonatomic,strong) NSString* oldValue; //
@property (nonatomic,strong) NSString* value; //value for params

@property (nonatomic,strong) NSString* unit; //unit
@property (nonatomic,strong) NSArray* option; //option
@property (nonatomic,strong) NSArray* combination_arr; //like area, location, and so on.F
@property (nonatomic,strong) id accessoryObject; //some kinds of addressModel, and so on.

-(BaseFormModel*)requiredModel;

@end

@interface BaseFormSection : ZZModel

@property (nonatomic,strong) NSString* d3scription;
@property (nonatomic,strong) NSArray<BaseFormModel*>* models;

@end

@interface BaseFormStep : ZZModel

@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSArray<BaseFormSection*>* sections;

@end

@interface BaseFormStepsModel : ZZModel

@property (nonatomic,strong) NSArray<BaseFormStep*>* steps;

-(BaseFormModel*)requiredModelWithStep:(NSInteger)step;

-(NSDictionary*)parameters;

@end

/* 面积
{
    combination_arr = [
    {
        field = long,
        hint = 请输入长,
        type = 1,
        unit = 米,
        name = 长
    },
    {
        field = width,
        hint = 请输入宽,
        type = 1,
        unit = 米,
        name = 宽
    },
    {
        field = high,
        hint = 请输入高,
        type = 1,
        unit = 米,
        name = 高
    },
    {
        field = hall_area,
        hint = 请输入展厅面积,
        type = 1,
        unit = m2,
        name = 展厅面积
    }
                       ],
    hint = ,
    name = 长宽高,
    field = ,
    type = 8
    },
*/
 
/*
{
    "code": 0,
    "message": "ok",
    "state": "success",
    "data": {
        "step1": {
            "title": "主场",
            "data": [
                     {
                         "description":" aosidfjoasjoiweoiwejfoweij",
                         "data":[
                          {
                              "name": "展会名称",
                              "field": "name",
                              "hint": "请输入展会名称",
                              "type": "1",
                              "required": "1"
                          }]
                     }
                     ]
        }
    }
}
*/
