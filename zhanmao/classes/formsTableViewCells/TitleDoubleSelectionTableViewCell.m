//
//  TitleDoubleSelectionTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleDoubleSelectionTableViewCell.h"
#import "PickerShadowContainer.h"
#import "FormHttpTool.h"

@interface TitleDoubleSelectionTableViewCell()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray* currentArray;
    
    NSArray* halls;
}
@end

@implementation TitleDoubleSelectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineHeight.constant=1/[[UIScreen mainScreen]scale];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self getHalls:^(NSArray *arr) {
            self.model.accessoryObject=arr;
            if (self.model.type==BaseFormTypeExhiHallSelection) {
                UIPickerView* pick=[[UIPickerView alloc]init];
                pick.dataSource=self;
                pick.delegate=self;
                pick.backgroundColor=[UIColor whiteColor];
                
                NSMutableArray* exhNames=[NSMutableArray array];
                for (HallModel* ha in halls) {
                    if (ha.hall_name.length>0) {
                        [exhNames addObject:ha.hall_name];
                    }
                }
                currentArray=exhNames;
                
                [pick reloadAllComponents];
//                title=[self.model.combination_arr.firstObject hint];
                BaseFormModel* firstObj=self.model.combination_arr.firstObject;
                BaseFormModel* secndObj=self.model.combination_arr.lastObject;
                NSString* title=firstObj.hint;

                [PickerShadowContainer showPickerContainerWithView:pick title:title completion:^{
//                    NSInteger sect=;
                    NSInteger row=[pick selectedRowInComponent:0];
                    NSString* selectedString=[self pickerView:pick titleForRow:row forComponent:0];
                    firstObj.value=selectedString;
                    self.model.value=selectedString;
                    
                    NSArray* seconArr=[[halls objectAtIndex:row] child];
                    currentArray=seconArr;
                    if(![currentArray containsObject:secndObj.value])
                    {
                        secndObj.value=nil;
                    }
                    
                    [self reloadModel];
                    
                    NSString* title2=secndObj.hint;
                    [pick reloadAllComponents];
                    [PickerShadowContainer showPickerContainerWithView:pick title:title2 completion:^{
                        NSInteger row=[pick selectedRowInComponent:0];
                        NSString* selectedString=[self pickerView:pick titleForRow:row forComponent:0];
                        secndObj.value=selectedString;
                        self.model.value=[NSString stringWithFormat:@"%@,%@",self.model.value,selectedString];
                        [self reloadModel];
                    }];
                }];
                //            [PickerShadowContainer ]
            }
        }];
        
    }
    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    BaseFormModel* firstObj=self.model.combination_arr.firstObject;
    BaseFormModel* secndObj=self.model.combination_arr.lastObject;
    
    self.title1.text=firstObj.name;
    self.title2.text=secndObj.name;
    self.text1.text=firstObj.value;
    self.text2.text=secndObj.value;
    
    self.placeHolder1.text=firstObj.hint;
    self.placeHolder2.text=secndObj.hint;
    self.placeHolder1.hidden=firstObj.value.length>0;
    self.placeHolder2.hidden=secndObj.value.length>0;
}

-(void)getHalls:(void(^)(NSArray* arr))success
{
    if (halls.count>0) {
        if (success) {
            success(halls);
        }
        
    }
    else
    {
        [MBProgressHUD showProgressMessage:@""];
        [FormHttpTool getHallNames:^(NSArray *h) {
            halls=h;
            [MBProgressHUD hide];
            if (success) {
                success(halls);
            }
        } failure:^(NSError *err) {
            [MBProgressHUD showErrorMessage:@"加载展馆列表失败"];
        }];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return currentArray.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [currentArray objectAtIndex:row];
}

@end
