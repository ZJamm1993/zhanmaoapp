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
    
    BaseFormTypeStepDescription                 =6,
    BaseFormTypeImage                           =61,
    
    BaseFormTypeAddressSelection                =7,
    
    BaseFormTypeCalculateArea                   =8,
    BaseFormTypeDoubleChoice                    =80,
    BaseFormTypeExhiHallSelection               =BaseFormTypeDoubleChoice,
    BaseFormTypeProviceCityDistrict             =81,
    BaseFormTypeCalculateSize                   =82,
    
    BaseFormTypeDatePicker                      =9,
    BaseFormTypeDateTimePicker                  =91,
    BaseFormTypeDateScopePicker                 =92,
    BaseFormTypeDateTime48Picker                =93,
};

typedef NS_ENUM(NSUInteger,BaseFormTextType)
{
    BaseFormTextTypeDefault,
    BaseFormTextTypePhone,
};

@interface BaseFormModel : ZZModel

@property (nonatomic,assign) BaseFormType type;

@property (nonatomic,assign) BaseFormTextType textType;

@property (nonatomic,assign) BOOL required; //allowed null or not
@property (nonatomic,strong) NSString* name; //title for cell
@property (nonatomic,strong) NSString* field; //key for params
@property (nonatomic,strong) NSString* hint; //place holder
@property (nonatomic,strong) NSString* thumb;

@property (nonatomic,strong) NSString* oldValue; //
@property (nonatomic,strong) NSString* value; //value for params

@property (nonatomic,strong) NSString* unit; //unit
@property (nonatomic,strong) NSArray* option; //option
@property (nonatomic,strong) NSArray* combination_arr; //like area, location, and so on.F
@property (nonatomic,strong) id accessoryObject; //some kinds of addressModel, array, and so on.

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

-(NSDictionary*)parametersWithModifiedKey:(NSString*)modify;

-(NSArray*)allModels;

@end
