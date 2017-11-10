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
    BaseFormTypeMutiChoice                      =3,
    BaseFormTypeCalculate                       =8,
    BaseFormTypeTimePicker                      =9,
    BaseFormTypeNormalUnit                      =11,
    BaseFormTypeLargeField                      =12,
    BaseFormTypeSingleChoice                    =31,
    BaseFormTypeSwitchCheck                     =32,
    BaseFormTypeProviceCityDistrict             =81,
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

@property (nonatomic,strong) NSString* d3scription;
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
