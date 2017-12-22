//
//  AddressAddNewFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/18.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "AddressAddNewFormTableViewController.h"
#import "MyLoginViewController.h"

@interface AddressAddNewFormTableViewController ()

@end

@implementation AddressAddNewFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新增地址";
    
    if ([UserModel token].length==0) {
        [MBProgressHUD showErrorMessage:AskToLoginDescription];
        [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadFormJson
{
    BaseFormStepsModel* steps=[[BaseFormStepsModel alloc]init];
    
    BaseFormStep* step=[[BaseFormStep alloc]init];
    step.title=@"新增地址";
    steps.steps=[NSArray arrayWithObject:step];
    
    BaseFormSection* section=[[BaseFormSection alloc]init];
    BaseFormSection* section2=[[BaseFormSection alloc]init];
    step.sections=[NSArray arrayWithObjects:section,section2, nil];
    ///////
    
    BaseFormModel* name=[[BaseFormModel alloc]init];
    name.name=@"姓名";
    name.field=@"addressee";
    name.hint=@"请填写姓名";
    name.type=BaseFormTypeNormal;
    name.required=YES;
    
    BaseFormModel* phone=[[BaseFormModel alloc]init];
    phone.name=@"联系电话";
    phone.field=@"phone";
    phone.hint=@"请填写正确的电话";
    phone.type=BaseFormTypeNormal;
    phone.textType=BaseFormTextTypePhone;
    phone.required=YES;
    
    BaseFormModel* address=[[BaseFormModel alloc]init];
    address.name=@"省市区";
    address.hint=@"请选择省市区";
    address.type=BaseFormTypeProviceCityDistrict;
    address.required=YES;
    
    BaseFormModel* province=[[BaseFormModel alloc]init];
    province.field=@"province";
    
    BaseFormModel* city=[[BaseFormModel alloc]init];
    city.field=@"city";
    
    BaseFormModel* district=[[BaseFormModel alloc]init];
    district.field=@"district";
    
    address.combination_arr=[NSArray arrayWithObjects:province,city,district, nil];
    
    BaseFormModel* detail=[[BaseFormModel alloc]init];
    detail.name=@"详细地址";
    detail.field=@"address";
    detail.hint=@"请填写详细地址";
    detail.type=BaseFormTypeNormal;
    detail.required=YES;
    
    section.models=[NSArray arrayWithObjects:name,phone,address,detail, nil];
    
    //////
    
    BaseFormModel* classic=[[BaseFormModel alloc]init];
    classic.name=@"设为默认";
    classic.field=@"classic";
    classic.hint=@"";
    classic.type=BaseFormTypeSwitchCheck;
    classic.required=YES;
    
    section2.models=[NSArray arrayWithObjects:classic, nil];
    
    if (self.editAddress) {
        name.value=self.editAddress.addressee;
        phone.value=self.editAddress.phone;
        province.value=self.editAddress.province;
        city.value=self.editAddress.city;
        district.value=self.editAddress.district;
        detail.value=self.editAddress.address;
        classic.value=self.editAddress.classic?@"1":@"0";
        address.value=[NSString stringWithFormat:@"%@%@%@",province.value,city.value,district.value];
    }
    
    self.formSteps=steps;
    [self.tableView reloadData];
    
    
}

-(void)submitToServer
{
    
//    [MBProgressHUD showProgressMessage:@"正在提交..."];
    NSMutableDictionary* paras=[NSMutableDictionary dictionaryWithDictionary:[self.formSteps parameters]];
    NSLog(@"%@",paras);
    
    NSString* token=[UserModel token];
    BOOL edit=(self.editAddress!=nil);
    
    if (edit) {
        [paras setValue:self.editAddress.idd forKey:@"id"];
    }
    
    if (token.length>0) {
        [paras setValue:token forKey:@"access_token"];
        [MBProgressHUD showProgressMessage:@"正在提交..."];
        [MyPageHttpTool postNewAddressEdit:edit param:paras success:^(BOOL result, NSString *msg, NSString* idd) {
            if (result) {
                [MBProgressHUD showSuccessMessage:msg];
                [self.navigationController popViewControllerAnimated:YES];
                if(!edit)
                {
                    [paras setValue:idd forKey:@"id"];
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:AddressAddNewNotification object:nil userInfo:paras];
            }
            else
            {
                [MBProgressHUD showErrorMessage:msg];
            }
        }];
    }
}

@end
