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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self getHalls:^(NSArray *arr) {
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
                NSString* title=@"";
                
                title=[self.model.combination_arr.firstObject hint];

                [PickerShadowContainer showPickerContainerWithView:pick title:title completion:^{
//                    NSInteger sect=;
                    NSString* selected=[self pickerView:pick titleForRow:[pick selectedRowInComponent:0] forComponent:0];
                    self.model.combination_arr.firstObject
                }]
                //            [PickerShadowContainer ]
            }
        }];
        
    }
    // Configure the view for the selected state
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

@end
