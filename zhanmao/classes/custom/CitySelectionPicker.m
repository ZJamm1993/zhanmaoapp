//
//  CitySelectionPicker.m
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CitySelectionPicker.h"

static NSMutableArray* provincesStaticArray;

@implementation DistrictModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.name=[dictionary valueForKey:@"name"];
        //NSLog(@"            3:%@",self.name);
        self.zipcode=[dictionary valueForKey:@"zipcode"];
    }
    return self;
}

@end

@implementation CityModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.name=[dictionary valueForKey:@"name"];
        //NSLog(@"        2:%@",self.name);
        NSArray* arr=[dictionary valueForKey:@"district"];
        NSMutableArray* rrm=[NSMutableArray array];
        if ([arr respondsToSelector:@selector(lastObject)]) {
            for (NSDictionary* dic in arr) {
                DistrictModel* m=[[DistrictModel alloc]initWithDictionary:dic];
                [rrm addObject:m];
            }
        }
        else if([arr respondsToSelector:@selector(allKeys)])
        {
            DistrictModel* m=[[DistrictModel alloc]initWithDictionary:(NSDictionary*)arr];
            [rrm addObject:m];
        }
        
        self.districts=rrm;
    }
    return self;
}

@end

@implementation ProvinceModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.name=[dictionary valueForKey:@"name"];
        //NSLog(@"1:%@",self.name);
        NSArray* arr=[dictionary valueForKey:@"city"];
        NSMutableArray* rrm=[NSMutableArray array];
        if ([arr respondsToSelector:@selector(lastObject)]) {
            for (NSDictionary* dic in arr) {
                CityModel* m=[[CityModel alloc]initWithDictionary:dic];
                [rrm addObject:m];
            }
        }
        else if([arr respondsToSelector:@selector(allKeys)])
        {
            CityModel* m=[[CityModel alloc]initWithDictionary:(NSDictionary*)arr];
            [rrm addObject:m];
        }
        self.citys=rrm;
    }
    return self;
}

@end

@interface CitySelectionPicker()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,assign) NSInteger sections;

@end

@implementation CitySelectionPicker

+(instancetype)defaultCityPickerWithSections:(NSInteger)sections
{
    CitySelectionPicker* picker=[[CitySelectionPicker alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.sections=sections;
    picker.delegate=picker;
    picker.dataSource=picker;
    
    return picker;
}

-(void)setSections:(NSInteger)sections
{
    if (sections>3) {
        sections=3;
    }
    else if(sections<0)
    {
        sections=0;
    }
    _sections=sections;
}

-(NSArray*)provinces
{
    if (provincesStaticArray==nil) {
        provincesStaticArray=[NSMutableArray array];
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"cityJson.txt"];
        NSError* err=nil;
        NSString* json=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
        NSData * data2 = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary* root=[result valueForKey:@"root"];
        NSArray* pros=[root valueForKey:@"province"];
        for (NSDictionary* pm in pros) {
            ProvinceModel* p=[[ProvinceModel alloc]initWithDictionary:pm];
            [provincesStaticArray addObject:p];
        }
    }
    return provincesStaticArray;
}

-(NSArray*)selectedCity
{
    NSMutableArray* arr=[NSMutableArray array];
    for (NSInteger i=0; i<self.sections; i++) {
        NSInteger selectedRowInComponent=[self selectedRowInComponent:i];
        NSString* title=[self pickerView:self titleForRow:selectedRowInComponent forComponent:i];
        if (title.length>0) {
            [arr addObject:title];
        }
    }
    return arr;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.sections;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return self.provinces.count;
    }
    else if(component==1)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        return pro.citys.count;
    }
    else if(component==2)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        se=[self selectedRowInComponent:1];
        CityModel* cit=[pro.citys objectAtIndex:se];
        return cit.districts.count;
    }
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        return [[self.provinces objectAtIndex:row]name];
    }
    else if(component==1)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        return [[pro.citys objectAtIndex:row]name];
    }
    else if(component==2)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        se=[self selectedRowInComponent:1];
        CityModel* cit=[pro.citys objectAtIndex:se];
        return [[cit.districts objectAtIndex:row]name];
    }
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadAllComponents];
}

@end
