//
//  BaseFormStepsModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseFormStepsModel.h"

@implementation BaseFormModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        
        self.type=[[dictionary valueForKey:@"type"]integerValue];
        self.required=[[dictionary valueForKey:@"required"]boolValue];
        self.name=[dictionary valueForKey:@"name"];
        self.field=[dictionary valueForKey:@"field"];
        self.hint=[dictionary valueForKey:@"hint"];
        self.unit=[dictionary valueForKey:@"unit"];
        self.thumb=[dictionary valueForKey:@"thumb"];
        self.option=[dictionary valueForKey:@"option"];
        if (![self.option isKindOfClass:[NSArray class]])
        {
            self.option=nil;
        }
        //default Value for some type
        if(self.type==BaseFormTypeSwitchCheck)
        {
            self.value=@"0";
        }
        
        NSMutableArray* coms=[NSMutableArray array];
        NSArray* coma=[dictionary valueForKey:@"combination_arr"];
        if (coma.count>0)
        {
            for (NSDictionary* comd_ in coma) {
                BaseFormModel* m=[[BaseFormModel alloc]initWithDictionary:comd_];
                [coms addObject:m];
            }
        }
        self.combination_arr=coms;
    }
    return self;
}

-(void)setValue:(NSString *)value
{
    self.oldValue=_value;
    _value=value;
}

-(BaseFormModel*)requiredModel
{
    BaseFormModel* r=nil;
    if (self.required&&self.value.length==0) {
        r=self;
    }
    else if(self.textType==BaseFormTextTypePhone&&![self.value isMobileNumber])
    {
        r=self;
    }
    else
    {
        for (BaseFormModel* chi in self.combination_arr) {
            r=[chi requiredModel];
        }
    }
    return r;
}

@end

@implementation BaseFormSection

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.d3scription=[dictionary valueForKey:@"description"];
        NSMutableArray* mutaMo=[NSMutableArray array];
        NSArray* data=[dictionary valueForKey:@"data"];
        for (NSDictionary* mo in data) {
            BaseFormModel* mod=[[BaseFormModel alloc]initWithDictionary:mo];
            if(mod.type==BaseFormTypeStepDescription)
            {
                self.d3scription=mod.hint;
            }
            else
            {
                [mutaMo addObject:mod];
            }
        }
        self.models=mutaMo;
    }
    return self;
}

@end

@implementation BaseFormStep

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    
    if (self) {
        self.title=[dictionary valueForKey:@"title"];
        NSArray* stepData=[dictionary valueForKey:@"data"];
        NSMutableArray* mutaStep=[NSMutableArray array];
        for (NSDictionary* section in stepData) {
            NSDictionary* secD=section;
            if ([secD respondsToSelector:@selector(lastObject)]) {
                secD=[NSDictionary dictionaryWithObject:secD forKey:@"data"];
            }
            BaseFormSection* sec=[[BaseFormSection alloc]initWithDictionary:secD];
            [mutaStep addObject:sec];
        }
        self.sections=mutaStep;
    }
    return self;
}

@end

@implementation BaseFormStepsModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        
        NSMutableArray* mutaSteps=[NSMutableArray array];
        if([dictionary  respondsToSelector:@selector(lastObject)])
        {
            NSArray* arr=(NSArray*)dictionary;
            for (NSDictionary* dic in arr) {
                BaseFormStep* step=[[BaseFormStep alloc]initWithDictionary:dic];
                [mutaSteps addObject:step];
            }

        }
        else
        {
            NSArray* allKey=dictionary.allKeys;
            if (allKey.count==0) {
                return self;
            }
            for (NSString* stepKey in allKey) {
                BaseFormStep* step=[[BaseFormStep alloc]initWithDictionary:[dictionary valueForKey:stepKey]];
                [mutaSteps addObject:step];
            }
        }
        
        self.steps=mutaSteps;
    }
    return self;
}

-(BaseFormModel*)requiredModelWithStep:(NSInteger)step
{
    BaseFormStep* st=[self.steps objectAtIndex:step];
    for (BaseFormSection* sections in st.sections) {
        for (BaseFormModel* mo in sections.models) {
             BaseFormModel* re =mo.requiredModel;
            if (re) {
                return re;
            }
        }
    }
    return nil;
}

-(NSDictionary*)parameters
{
    return [self parametersWithModifiedKey:nil];
}

-(NSDictionary*)parametersWithModifiedKey:(NSString *)modify
{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSArray* alls=[self allModels];
    for (BaseFormModel* mo in alls) {
        if (mo.field.length>0&&mo.value.length>0) {
            NSString* key=mo.field;
            if (modify.length>0) {
                key=[NSString stringWithFormat:@"%@[%@]",modify,mo.field];
            }
            [dic setValue:mo.value forKey:key];
        }
    }
    return dic;
}

-(NSArray*)allModels
{
    NSMutableArray* arr=[NSMutableArray array];
    
    for (BaseFormStep* st in self.steps) {
        for (BaseFormSection* sections in st.sections) {
            for (BaseFormModel* mo in sections.models) {
                [self findModels:arr inModel:mo];
            }
        }
    }
    
    return arr;
}

-(void)findModels:(NSMutableArray*)models inModel:(BaseFormModel*)model
{
    [models addObject:model];
    for (BaseFormModel* mo in model.combination_arr) {
        [self findModels:models inModel:mo];
    }
}

@end
