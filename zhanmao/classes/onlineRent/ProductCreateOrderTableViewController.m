//
//  ProductCreateOrderTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ProductCreateOrderTableViewController.h"
#import "BaseFormTableViewController.h"
#import "RentNewOrderPriceTableViewCell.h"
#import "RentCartEditTableViewCell.h"
#import "RentHttpTool.h"
#import "TotalFeeView.h"
#import "MyPageHttpTool.h"

#import "PayOrderTableViewController.h"

typedef NS_ENUM(NSInteger,ProductCreateOrderSection)
{
    ProductCreateOrderSectionAddress,
    ProductCreateOrderSectionInfos,
    ProductCreateOrderSectionGoods,
    ProductCreateOrderSectionCycle,
    ProductCreateOrderSectionPrices,
    
    ProductCreateOrderSectionTotalCount
};

@interface ProductCreateOrderTableViewController ()<FormBaseTableViewCellDelegate>
{
    NSArray* addressSectionArray;
    NSArray* infosSectionArray;
    NSArray* goodsSectionArray;
    NSArray* cycleSectionArray;
    NSArray* pricesSectionArray;
    
    NSArray* nibsToRegister;
    
    CGFloat rent;
    CGFloat deposit;
    CGFloat total;
    
    TotalFeeView* _totalFeeView;
}


@end

@implementation ProductCreateOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交订单";
    
    [self.bottomButton removeFromSuperview];
    _totalFeeView=[[[UINib nibWithNibName:@"TotalFeeView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    CGRect fr=self.bottomFrame;
    fr.size.height=64;
    _totalFeeView.frame=fr;
    [_totalFeeView.submitButton addTarget:self action:@selector(orderSubmit) forControlEvents:UIControlEventTouchUpInside];
//    _totalFeeView.submitButton.enabled=NO;
    [self setBottomSubView:_totalFeeView];
    
    _totalFeeView.feeLabe.text=[NSString stringWithFloat:total headUnit:@"¥" tailUnit:nil];
    
    nibsToRegister=[NSArray arrayWithObjects:
                    NSStringFromClass([TitleTextViewTableViewCell class]),
                    NSStringFromClass([TitleTextFieldTableViewCell class]),
                    NSStringFromClass([TitleSingleSelectionTableViewCell class]),
                    NSStringFromClass([TitleMutiSelectionTableViewCell class]),
                    NSStringFromClass([TitleDescriptionTableViewCell class]),
                    NSStringFromClass([TitleAreaCalculationTableViewCell class]),
                    NSStringFromClass([TitleSwitchTableViewCell class]),
                    NSStringFromClass([TitleAddressSeletectTableViewCell class]),
                    NSStringFromClass([TitleNoneImageTableViewCell class]),
                    NSStringFromClass([TitleDoubleSelectionTableViewCell class]),
                    nil];
    
    for (NSString* nibName in nibsToRegister) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    }
    
    addressSectionArray=[self addressSectionArray];
    infosSectionArray=[self infosSectionArray];
    goodsSectionArray=[self goodsSectionArray];
    cycleSectionArray=[self cycleSectionArray];
    pricesSectionArray=[self priceSectionArray];
    
    [self calculatePrices];
    
    [MyPageHttpTool getMyAddressesToken:[UserModel token] cache:NO success:^(NSArray *result) {
        for (AddressModel* add in result) {
            if (add.classic) {
                BaseFormModel* addModel=addressSectionArray.firstObject;
                if (addModel.accessoryObject==nil) {
                    addModel.accessoryObject=add;
                    addModel.value=add.idd;
                    [self.tableView reloadData];
                }
                break;
            }
        }
    } failure:nil];
}

#pragma mark calculate

-(void)calculatePrices
{
    
    BaseFormModel* daysSelectionModel=[cycleSectionArray firstObject];
    if (daysSelectionModel) {
        if (daysSelectionModel.value.length>0) {
            if ([daysSelectionModel.option containsObject:daysSelectionModel.value]) {
                NSInteger ind=[daysSelectionModel.option indexOfObject:daysSelectionModel.value];
                NSInteger cycles=ind+1;
                
                CGFloat allRents=0;
                CGFloat allDepos=0;
                
                for (RentCartModel* car in self.cartObjects) {
                    CGFloat thisRent=car.product.rent;
                    CGFloat thisDepo=car.product.deposit;
                    
                    CGFloat thisTotalRent=thisRent*car.count*cycles;
                    CGFloat thisTotalDepo=thisDepo*car.count; //未知押金算法
//#warning unknow deposit calculation;
                    
                    allRents=allRents+thisTotalRent;
                    allDepos=allDepos+thisTotalDepo;
                }
                
                rent=allRents;
                deposit=allDepos;
                total=rent+deposit;
                
                _totalFeeView.feeLabe.text=[NSString stringWithFloat:total headUnit:@"¥" tailUnit:nil];
                _totalFeeView.title.text=@"需付款：";
                
                NSArray* allVisibleCells=[self.tableView visibleCells];
                for (UITableViewCell* cel in allVisibleCells) {
                    if ([cel isKindOfClass:[RentNewOrderPriceTableViewCell class]]) {
                        RentNewOrderPriceTableViewCell* rentCell=(RentNewOrderPriceTableViewCell*)cel;
                        rentCell.rent.text=[NSString stringWithFloat:rent headUnit:@"¥" tailUnit:nil];
                        rentCell.deposit.text=[NSString stringWithFloat:deposit headUnit:@"¥" tailUnit:nil];
                        rentCell.total.text=[NSString stringWithFloat:total headUnit:@"¥" tailUnit:nil];
                    }
                }
            }
        }
    }
}

#pragma mark datas

-(NSArray*)addressSectionArray;
{
    BaseFormModel* form=[[BaseFormModel alloc]init];
    form.type=BaseFormTypeAddressSelection;
    form.required=YES;
    form.hint=@"请填写收货地址";
    
    NSMutableArray* combination=[NSMutableArray array];
    for (NSInteger i=0; i<6; i++) {
        BaseFormModel* subModel=[[BaseFormModel alloc]init];
        if (i==0)
        {
            subModel.field=@"addressee";
        }
        else if (i==1) {
            subModel.field=@"phone";
        }
        else if (i==2) {
            subModel.field=@"province";
        }
        else if (i==3) {
            subModel.field=@"city";
        }
        else if (i==4) {
            subModel.field=@"district";
        }
        else if (i==5) {
            subModel.field=@"address";
        }
//        if(!(i==5||i==4)
//        subModel.required=YES;
        subModel.hint=@"请选择地址";
        [combination addObject:subModel];
    }
    form.combination_arr=combination;
    
    return [NSArray arrayWithObject:form];
}

-(NSArray*)infosSectionArray;
{
    BaseFormModel* form=[[BaseFormModel alloc]init];
    form.type=BaseFormTypeNormal;
    form.name=@"紧急电话";
    form.hint=@"请输入紧急联系电话";
    form.field=@"emergency_phone";
    
    BaseFormModel* form2=[[BaseFormModel alloc]init];
    form2.type=BaseFormTypeDatePicker;
    form2.name=@"配送时间";
    form2.required=YES;
    form2.hint=@"请选择配送时间";
    form2.field=@"delivery_date";
    
    return [NSArray arrayWithObjects:form, form2, nil];
}

-(NSArray*)goodsSectionArray;
{
    NSMutableArray* array=[NSMutableArray arrayWithObject:[NSNumber numberWithInt:0]];
    if(self.cartObjects.count>0)
    {
        [array addObjectsFromArray:self.cartObjects];
    }
    return array;
}

-(NSArray*)cycleSectionArray;
{
    BaseFormModel* form=[[BaseFormModel alloc]init];
    form.type=BaseFormTypeSingleChoice;
    form.name=@"商品租期";
    form.hint=@"请选择商品租期(4天为一周期)";
    form.required=YES;
    form.field=@"rent_days";
    NSMutableArray* options=[NSMutableArray array];
    for (NSInteger i=1; i<=5; i++) {
        NSString* str=[NSString stringWithFormat:@"%ld周期(%ld天)",(long)i,(long)(i*4)];
        [options addObject:str];
    }
    form.option=options;
    return [NSArray arrayWithObject:form];
}

-(NSArray*)priceSectionArray
{
    return [NSArray arrayWithObject:[NSNumber numberWithInt:0]];
}

#pragma mark tableviews

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ProductCreateOrderSectionTotalCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==ProductCreateOrderSectionAddress) {
        return addressSectionArray.count;
    }
    else if(section==ProductCreateOrderSectionInfos)
    {
        return infosSectionArray.count;
    }
    else if(section==ProductCreateOrderSectionGoods)
    {
        return goodsSectionArray.count;
    }
    else if(section==ProductCreateOrderSectionCycle)
    {
        return cycleSectionArray.count;
    }
    else if(section==ProductCreateOrderSectionPrices)
    {
        return pricesSectionArray.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    if(section==ProductCreateOrderSectionGoods)
    {
        if (row==0) {
            return [tableView dequeueReusableCellWithIdentifier:@"ProductInfoHeader" forIndexPath:indexPath];
        }
        RentCartModel* mo=[goodsSectionArray objectAtIndex:row];
        RentCartEditTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentCartEditTableViewCell" forIndexPath:indexPath];
        cell.cartModel=mo;
        return cell;
    }
    else if(section==ProductCreateOrderSectionPrices)
    {
        RentNewOrderPriceTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"RentNewOrderPriceTableViewCell" forIndexPath:indexPath];
        cell.rent.text=[NSString stringWithFloat:rent headUnit:@"¥" tailUnit:nil];
        cell.deposit.text=[NSString stringWithFloat:deposit headUnit:@"¥" tailUnit:nil];
        cell.total.text=[NSString stringWithFloat:total headUnit:@"¥" tailUnit:nil];
        return cell;
        
    }
    else
    {
        NSArray* arr=nil;
        if (section==ProductCreateOrderSectionAddress) {
            arr=addressSectionArray;
        }
        else if(section==ProductCreateOrderSectionInfos)
        {
            arr=infosSectionArray;
        }
        else if(section==ProductCreateOrderSectionCycle)
        {
            arr=cycleSectionArray;
        }
        if (arr.count>0) {
            BaseFormModel* formModel=[arr objectAtIndex:row];
            NSString* nibName=@"ProductInfoHeader";
            
            NSString* nibb=[BaseFormTableViewController cellNibNameForFormType:formModel.type];
            if(nibb.length>0)
            {
                nibName=nibb;
            }
            
            FormBaseTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
            if ([cell respondsToSelector:@selector(setModel:)]) {
                [cell performSelector:@selector(setModel:) withObject:formModel];
            }
            if ([cell respondsToSelector:@selector(setDelegate:)]) {
                [cell performSelector:@selector(setDelegate:) withObject:self];
            }
            return cell;
        }
    }
    
    return [[UITableViewCell alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==tableView.numberOfSections-1) {
        return UITableViewAutomaticDimension;
    }
    return 10;
}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section==tableView.numberOfSections-1) {
        return @"押金会在交易完成后的72小时内原路返回";
    }
    return nil;
}

#pragma mark formbasetableviewcelldelegate

-(void)formBaseTableViewCellValueChanged:(FormBaseTableViewCell *)cell
{
    [self calculatePrices];
}

-(void)formBaseTableViewCell:(FormBaseTableViewCell *)cell shouldPushViewController:(UIViewController *)viewController
{
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

-(void)orderSubmit
{
    NSMutableArray* realGoods=[NSMutableArray array];
    for (NSObject* obj in goodsSectionArray) {
        if ([obj isKindOfClass:[RentCartModel class]]) {
            [realGoods addObject:obj];
        }
    }
    NSInteger goodsCount=realGoods.count;
    if (goodsCount==0) {
        [MBProgressHUD showErrorMessage:@"未选择商品"];
        return;
    }
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    
    NSArray* forms=[self allFormsModel];
    
    for (BaseFormModel* mo in forms) {
        if (mo.requiredModel) {
            [MBProgressHUD showErrorMessage:mo.requiredModel.hint];
            return;
        }
        
        if(mo.field.length>0)
        {
            NSString* value=mo.value;
            if(mo.type==BaseFormTypeSingleChoice)
            {
                if ([mo.option containsObject:value]) {
                    NSInteger i=[mo.option indexOfObject:value];
                    value=[NSString stringWithFormat:@"%ld",(long)i+1];
                }
            }
            
            [dic setValue:value forKey:mo.field];
        }
    }
    
    
    for (NSInteger i=0;i<goodsCount;i++) {
        
        RentCartModel* car=[realGoods objectAtIndex:i];
        
        NSString* goosKey=[NSString stringWithFormat:@"goods[%ld]",(long)i+1];
        NSString* goosValue=car.product.idd;
        
        NSString* saleNumKey=[NSString stringWithFormat:@"sale_num[%ld]",(long)i+1];
        NSNumber* saleNumValue=[NSNumber numberWithInteger:car.count];
        
        [dic setValue:goosValue forKey:goosKey];
        [dic setValue:saleNumValue forKey:saleNumKey];
    }
    
    if ([UserModel token].length==0) {
        [MBProgressHUD showErrorMessage:AskToLoginDescription];
        return;
    }
    
    [dic setValue:[UserModel token] forKey:@"access_token"];
    
    NSLog(@"%@",dic);
    
    [RentHttpTool postRentOrderParams:dic success:^(BOOL result, NSString *msg, PayOrderModel *order) {
        if(result)
        {
            [MBProgressHUD showSuccessMessage:msg];
            if (order.idd.length>0) {
                PayOrderTableViewController* pay=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"PayOrderTableViewController"];
                pay.orderModel=order;
                pay.orderType=PayOrderTypeRent;
                [self.navigationController pushViewController:pay animated:YES];
                
                NSMutableArray* vcs=[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
                if ([vcs containsObject:self]) {
                    [vcs removeObject:self];
                }
                self.navigationController.viewControllers=vcs;
            }
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
    }];
}

-(NSArray*)allFormsModel
{
//    NSArray* addressSectionArray;
//    NSArray* infosSectionArray;
//    NSArray* goodsSectionArray;
//    NSArray* cycleSectionArray;
//    NSArray* pricesSectionArray;
    
    NSMutableArray* arr=[NSMutableArray array];
    
    NSArray* arrs=[NSArray arrayWithObjects:addressSectionArray,infosSectionArray,cycleSectionArray, nil];
    for (NSArray* a in arrs) {
        for (BaseFormModel* mo in a) {
            [self findModels:arr inModel:mo];
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
