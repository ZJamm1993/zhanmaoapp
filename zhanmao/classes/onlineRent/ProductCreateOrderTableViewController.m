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

#import "TotalFeeView.h"

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
    CGRect fr=self.bottomToolBar.bounds;
    fr.size.height=64;
    _totalFeeView.frame=fr;
    [_totalFeeView.submitButton addTarget:self action:@selector(orderSubmit) forControlEvents:UIControlEventTouchUpInside];
    _totalFeeView.submitButton.enabled=NO;
    [self.bottomToolBar addSubview:_totalFeeView];
    
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
}

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
                    CGFloat thisTotalDepo=thisDepo*car.count;
                    
                    allRents=allRents+thisTotalRent;
                    allDepos=allDepos+thisTotalDepo;
                }
                
                rent=allRents;
                deposit=allDepos;
                total=rent+deposit;
                
                _totalFeeView.feeLabe.text=[NSString stringWithFloat:total headUnit:@"¥" tailUnit:nil];
                
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

-(NSArray*)addressSectionArray;
{
    BaseFormModel* form=[[BaseFormModel alloc]init];
    form.type=BaseFormTypeAddressSelection;
    form.required=YES;
    form.name=@"收";
    form.hint=@"请填写收货地址";
    return [NSArray arrayWithObject:form];
}

-(NSArray*)infosSectionArray;
{
    BaseFormModel* form=[[BaseFormModel alloc]init];
    form.type=BaseFormTypeNormal;
    form.name=@"紧急电话";
    form.hint=@"请输入紧急联系电话";
    
    BaseFormModel* form2=[[BaseFormModel alloc]init];
    form2.type=BaseFormTypeDatePicker;
    form2.name=@"配送时间";
    form2.required=YES;
    form2.hint=@"请选择配送时间";
    
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
    form.name=@"商品租期(4天为一周期)";
    form.hint=@"请选择商品租期";
    form.required=YES;
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

-(void)formBaseTableViewCellValueChanged:(FormBaseTableViewCell *)cell
{
//    if(cell.model.type==BaseFormTypeSingleChoice)
//    {
        [self calculatePrices];
//    }
    
    
}

-(void)formBaseTableViewCell:(FormBaseTableViewCell *)cell shouldPushViewController:(UIViewController *)viewController
{
    if (viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

-(void)orderSubmit
{
    
}

//-(NSArray*)allModels
//{
//    NSMutableArray* arr=[NSMutableArray array];
//    
////    BaseFormModel* addressModel=addressSectionArray.firstObject;
////    if (addressModel.combination_arr.count>0) {
////        statements
////    }
//}

@end
