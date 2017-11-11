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
        self.option=[dictionary valueForKey:@"option"];
        
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
            [mutaMo addObject:mod];
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
        NSArray* allKey=dictionary.allKeys;
        if (allKey.count==0) {
            return self;
        }
        for (NSString* stepKey in allKey) {
            BaseFormStep* step=[[BaseFormStep alloc]initWithDictionary:[dictionary valueForKey:stepKey]];
            [mutaSteps addObject:step];
        }
        self.steps=mutaSteps;
    }
    return self;
}

-(NSString*)warningStringForStep:(NSInteger)step
{
    if (step<=self.steps.count-1) {
        BaseFormStep* st=[self.steps objectAtIndex:step];
        for (BaseFormSection* sections in st.sections) {
            for (BaseFormModel* mo in sections.models) {
                if (mo.required) {
                    if (mo.value.length==0) {
                        NSLog(@"%@",mo);
                        return mo.hint;
                    }
                }
                for(BaseFormModel* smo in mo.combination_arr)
                {
                    if (smo.required) {
                        if (smo.value.length==0) {
                            NSLog(@"%@",mo);
                            return smo.hint;
                        }
                    }
                }
            }
        }
    }
    return @"";
}

-(NSDictionary*)parameters
{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    for (BaseFormStep* st in self.steps) {
        for (BaseFormSection* sections in st.sections) {
            for (BaseFormModel* mo in sections.models) {
                if (mo.field.length>0&&mo.value.length>0) {
                    [dic setValue:mo.value forKey:mo.field];
                }
                for(BaseFormModel* smo in mo.combination_arr)
                {
                    if (smo.field.length>0&&smo.value.length>0) {
                        [dic setValue:smo.value forKey:smo.field];
                    }
                }
            }
        }
    }
    return dic;
}

@end
