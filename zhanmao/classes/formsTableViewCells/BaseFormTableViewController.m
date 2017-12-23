//
//  BaseFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseFormTableViewController.h"
#import "UserModel.h"
#import "MyLoginViewController.h"

@interface BaseFormTableViewController ()
{
    NSArray* nibsToRegister;
    UIButton* submitButton;
    UIActivityIndicatorView* loadingView;
    CGFloat bottomSafe;
}
@end

@implementation BaseFormTableViewController

#if XcodeSDK11
-(void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    if ([self.view respondsToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets est=[self.view safeAreaInsets];
            bottomSafe=est.bottom;
            [self relayoutViews];
            //            self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
//            [self scrollViewDidScroll:self.tableView];
        } else {
            // Fallback on earlier versions
        }
    }
}
#endif

#pragma mark viewcontrollers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"正在加载...";
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-64-bottomSafe) style:UITableViewStyleGrouped];
    self.tableView.estimatedRowHeight=44;
    self.tableView.estimatedSectionFooterHeight=0;
    self.tableView.estimatedSectionHeaderHeight=0;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    if (self.tableView.style==UITableViewStyleGrouped) {
        self.tableView.backgroundColor=gray_9;
    }
//    self.tableView.separatorColor=[UIColor groupTableViewBackgroundColor];
    
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
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        // Fallback on earlier versions
//    }
    [self.view addSubview:self.tableView];
    
//    [self.tableView reloadData];
    
    UIView* bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height-bottomSafe, self.tableView.frame.size.width, 200)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    self.bottomView=bottomView;
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, 1/[[UIScreen mainScreen]scale])];
    line.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [bottomView addSubview:line];
    
    submitButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, bottomView.frame.size.width-20, 64-20)];
    submitButton.backgroundColor=_mainColor;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [submitButton addTarget:self action:@selector(checkAndAction) forControlEvents:UIControlEventTouchUpInside];
    [submitButton.layer setCornerRadius:4];
    [submitButton.layer setMasksToBounds:YES];
    [bottomView addSubview:submitButton];
    self.bottomButton=submitButton;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHides:) name:UIKeyboardWillHideNotification object:nil];
    
//#warning do not show this title
//    self.title=NSStringFromClass(self.class);
    
    loadingView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.center=CGPointMake(self.view.center.x,100);
    loadingView.hidesWhenStopped=YES;
    [self.view addSubview:loadingView];
    
    [loadingView startAnimating];
    
    [self setStepsTable];
    [self performSelector:@selector(relayoutViews) withObject:nil afterDelay:0.01];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if ([UserModel token].length==0) {
//        [self.navigationController popViewControllerAnimated:YES];
//        self
//        return;
//    }
    if (self.formSteps.steps.count==0) {
        [self loadFormJson];
    }
}

-(void)relayoutViews
{
    self.tableView.frame=CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-64-bottomSafe);
    self.bottomView.frame=CGRectMake(0, self.tableView.frame.size.height, self.tableView.frame.size.width, 200);
}

#pragma mark keyboards

-(void)keyboardShows:(NSNotification*)noti
{
//    NSLog(@"%@",noti);
    
    //UIKeyboardFrameEndUserInfoKey;
    //UIKeyboardAnimationDurationUserInfoKey;
    //UIKeyboardAnimationCurveUserInfoKey;
    
    [self keyboardAnimationWithNotification:noti showing:YES];
}

-(void)keyboardHides:(NSNotification*)noti
{
//    NSLog(@"%@",noti);
    
    [self keyboardAnimationWithNotification:noti showing:NO];
}

-(void)keyboardAnimationWithNotification:(NSNotification*)noti showing:(BOOL)showing
{
    NSDictionary* userinfo=noti.userInfo;
    
    CGFloat frameY=[[userinfo valueForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    CGFloat animaD=[[userinfo valueForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:animaD animations:^{
        CGRect fr=self.tableView.frame;
        fr.size.height=frameY-64;//-64; //-64to show bottombar while editing
        self.tableView.frame=fr;
        if (!showing) {
            self.tableView.frame=CGRectMake(0, 0, self.view.frame.size.width,[UIScreen mainScreen].bounds.size.height-64-64);
        }
        
        fr=self.bottomView.frame;
        fr.origin.y=self.tableView.frame.size.height;
        self.bottomView.frame=fr;
    }];
}

#pragma mark datas

-(void)loadFormJson
{
    NSLog(@"%@ valueChanged, please overwrite",self);
}

-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    //    lastCount=_dataSource.count;
    return _dataSource;
}

-(void)setFormSteps:(BaseFormStepsModel *)formSteps
{
    _formSteps=formSteps;
    if (formSteps.steps.count==0) {
        [MBProgressHUD showErrorMessage:@"无法获取表格"];
        return ;
    }
    [self setStepsTable];
}

-(void)setStepInteger:(NSInteger)stepInteger
{
    _stepInteger=stepInteger;
    [self setStepsTable];
}

-(void)setCurrentStep:(BaseFormStep *)currentStep
{
    _currentStep=currentStep;
    self.title=currentStep.title;
}

-(void)setStepsTable
{
    if (self.formSteps.steps.count==0) {
        return;
    }
    [loadingView stopAnimating];
    
    if (self.stepInteger<=self.formSteps.steps.count-1) {
        self.currentStep=((BaseFormStep*)[self.formSteps.steps objectAtIndex:self.stepInteger]);
    }
    
    if(self.stepInteger<self.formSteps.steps.count-1)
    {
        [submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    
    [self prefixValuesIfNeed];
    
    [self.tableView reloadData];
    
    [self valueChanged];
}

-(void)prefixValuesIfNeed
{
    if ([self.prefixValues respondsToSelector:@selector(allKeys)]) {
        NSArray* allModels=[self.formSteps allModels];
        NSArray* allKeys=self.prefixValues.allKeys;
        for (BaseFormModel* mo in allModels) {
            NSString* field=mo.field;
            if ([allKeys containsObject:field]) {
                NSString* value=[self.prefixValues valueForKey:field];
                mo.value=value;
            }
        }
    }
    //set nil after using;
    self.prefixValues=nil;
}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    BaseFormSection* sec=[self.currentStep.sections objectAtIndex:section];
    if (sec.d3scription.length>0) {
        return UITableViewAutomaticDimension;
    }
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.currentStep.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BaseFormSection* arr=[self.currentStep.sections objectAtIndex:section];
    return arr.models.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    BaseFormSection* sectio=[self.currentStep.sections objectAtIndex:section];
    BaseFormModel* model=[sectio.models objectAtIndex:row];
    
    NSString* nibName=[BaseFormTableViewController cellNibNameForFormType:model.type];
    
    if (![nibsToRegister containsObject:nibName]) {
        return [[FormBaseTableViewCell alloc]init];
    }
    
    FormBaseTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
    cell.model=model;
    if ([cell respondsToSelector:@selector(setDelegate:)]) {
        [cell performSelector:@selector(setDelegate:) withObject:self];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    BaseFormSection* sec=[self.currentStep.sections objectAtIndex:section];
    return sec.d3scription;
}

#pragma mark formbasetableviewcelldelegate

-(void)formBaseTableViewCellWillBeginEditing:(FormBaseTableViewCell *)cell
{
    NSIndexPath* indexpath=[self.tableView indexPathForCell:cell];
    [self scrollToIndexPath:indexpath];
}

-(void)formBaseTableViewCellValueChanged:(FormBaseTableViewCell *)cell
{
    NSLog(@"%@ valueChanged?",cell);
    [self valueChanged];
}

-(void)formBaseTableViewCell:(FormBaseTableViewCell *)cell shouldPushViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark editing

-(void)valueChanged
{
    NSLog(@"valuechanged");
    NSLog(@"%@",[self.formSteps parameters]);
}

-(void)scrollToIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark submitform

-(void)checkAndAction
{
    if(self.formSteps.steps.count==0)
    {
        return;
    }
    BaseFormModel* requiredModel=[self.formSteps requiredModelWithStep:self.stepInteger];
    if (requiredModel) {
        NSString* warning=requiredModel.hint;
        if (warning.length==0) {
            warning=requiredModel.name;
        }
        [MBProgressHUD showErrorMessage:warning];
        return;
    }
    if (self.stepInteger<self.formSteps.steps.count-1) {
        BaseFormTableViewController* nextPage=(BaseFormTableViewController*)[[[self class]alloc]init];
        nextPage.stepInteger=self.stepInteger+1;
        nextPage.formSteps=self.formSteps;
        nextPage.type=self.type;
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    else
    {
        //really submit
        if ([UserModel token].length==0) {
            [MBProgressHUD showErrorMessage:AskToLoginDescription];
            [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
            return;
        }
        [self submitToServer];
    }
}

-(void)submitToServer
{
    //        [MBProgressHUD showSuccessMessage:@"最后一页了"];
    [MBProgressHUD showProgressMessage:@"正在提交..."];
    NSMutableDictionary* paras=[NSMutableDictionary dictionaryWithDictionary:[self.formSteps parametersWithModifiedKey:@"data"]];
//    [paras setValue:[NSNumber numberWithInteger:self.type] forKey:@"type"];
    NSLog(@"%@",paras);
    [paras setValue:[UserModel token] forKey:@"access_token"];
    [FormHttpTool postCustomTableListByType:[self type] params:paras success:^(BOOL result, NSString *msg,PayOrderModel* pay) {
        [MBProgressHUD hide];
        if(result)
        {
//            [MBProgressHUD showSuccessMessage:msg];
            BOOL shouldPay=[self shouldHandlePayOrder:pay];
            if (!shouldPay) {
                [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MainPage" bundle:nil]instantiateViewControllerWithIdentifier:@"CustomFormSubmitResultViewController"] animated:YES];
                
                [self.navigationController removeViewControllersKindOfClass:[BaseFormTableViewController class]];
            }
            else
            {
                [MBProgressHUD showSuccessMessage:msg];
            }
        }
        else
        {
            [MBProgressHUD showErrorMessage:msg];
        }
        
    } failure:^(NSError *err) {
        NSLog(@"wangluo");
        [MBProgressHUD showErrorMessage:@"服务器出错"];
    }];

}

-(BOOL)shouldHandlePayOrder:(PayOrderModel *)payOrder
{
    NSLog(@"over write shouldHandlePayOrder: and return YES to handle pay");
    return NO;
}

#pragma mark cells selector

+(NSString*)cellNibNameForFormType:(BaseFormType)type
{
    NSString* nibName=@"";
    if (type==BaseFormTypeNormal||type==BaseFormTypeNormalUnit)
    {
        nibName=NSStringFromClass([TitleTextFieldTableViewCell class]);
    }
    else if(type==BaseFormTypeLargeField)
    {
        nibName=NSStringFromClass([TitleTextViewTableViewCell class]);
    }
    else if(type==BaseFormTypeDatePicker||type==BaseFormTypeDateTimePicker||type==BaseFormTypeDateTime48Picker||type==BaseFormTypeDateScopePicker||type==BaseFormTypeSingleChoice||type==BaseFormTypeProviceCityDistrict)
    {
        nibName=NSStringFromClass([TitleSingleSelectionTableViewCell class]);
    }
    else if(type==BaseFormTypeMutiChoice)
    {
        nibName=NSStringFromClass([TitleMutiSelectionTableViewCell class]);
    }
    else if(type==BaseFormTypeStepDescription)
    {
        nibName=NSStringFromClass([TitleDescriptionTableViewCell class]);
    }
    else if(type==BaseFormTypeCalculateArea||type==BaseFormTypeCalculateSize)
    {
        nibName=NSStringFromClass([TitleAreaCalculationTableViewCell class]);
    }
    else if(type==BaseFormTypeSwitchCheck)
    {
        nibName=NSStringFromClass([TitleSwitchTableViewCell class]);
    }
    else if(type==BaseFormTypeAddressSelection)
    {
        nibName=NSStringFromClass([TitleAddressSeletectTableViewCell class]);
    }
    else if(type==BaseFormTypeImage)
    {
        nibName=NSStringFromClass([TitleNoneImageTableViewCell class]);
    }
    else if(type==BaseFormTypeDoubleChoice)
    {
        nibName=NSStringFromClass([TitleDoubleSelectionTableViewCell class]);
    }
    return nibName;
}

@end
