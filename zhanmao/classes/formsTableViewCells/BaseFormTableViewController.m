//
//  BaseFormTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseFormTableViewController.h"

@interface BaseFormTableViewController ()
{
    NSArray* nibsToRegister;
    UIButton* submitButton;
}
@end

@implementation BaseFormTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-64) style:UITableViewStyleGrouped];
    self.tableView.estimatedRowHeight=44;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    nibsToRegister=[NSArray arrayWithObjects:
                             NSStringFromClass([TitleTextViewTableViewCell class]),
                             NSStringFromClass([TitleTextFieldTableViewCell class]),
                             NSStringFromClass([TitleSingleSelectionTableViewCell class])
                             , nil];
    for (NSString* nibName in nibsToRegister) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    }
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
//    [self.tableView reloadData];
    
    UIView* bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.tableView.frame.size.width, 64)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bottomView.frame.size.width, 1/[[UIScreen mainScreen]scale])];
    line.backgroundColor=[UIColor lightGrayColor];
    [bottomView addSubview:line];
    
    submitButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, bottomView.frame.size.width-20, bottomView.frame.size.height-20)];
    submitButton.backgroundColor=_mainColor;
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submitButton.layer setCornerRadius:4];
    [submitButton.layer setMasksToBounds:YES];
    [bottomView addSubview:submitButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHides:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setStepsTable];
    
    if (self.formSteps.steps.count==0) {
        [self loadFormJson];
    }
    // Do any additional setup after loading the view.
}

-(void)loadFormJson
{
    NSLog(@"%@ valueChanged, please overwrite",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    //    lastCount=_dataSource.count;
    return _dataSource;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark keyboards

-(void)keyboardShows:(NSNotification*)noti
{
//    NSLog(@"%@",noti);
    
    //UIKeyboardFrameEndUserInfoKey;
    //UIKeyboardAnimationDurationUserInfoKey;
    //UIKeyboardAnimationCurveUserInfoKey;
    
    [self keyboardAnimationWithNotification:noti];
}

-(void)keyboardHides:(NSNotification*)noti
{
//    NSLog(@"%@",noti);
    
    [self keyboardAnimationWithNotification:noti];
}

-(void)keyboardAnimationWithNotification:(NSNotification*)noti
{
    NSDictionary* userinfo=noti.userInfo;
    
    CGFloat frameY=[[userinfo valueForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    CGFloat animaD=[[userinfo valueForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    [UIView animateWithDuration:animaD animations:^{
        CGRect fr=self.tableView.frame;
        fr.size.height=frameY-64;
        self.tableView.frame=fr;
    }];
}

#pragma mark tableViews

-(void)setFormSteps:(BaseFormStepsModel *)formSteps
{
    _formSteps=formSteps;
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
    if (self.stepInteger<=self.formSteps.steps.count-1) {
        self.currentStep=((BaseFormStep*)[self.formSteps.steps objectAtIndex:self.stepInteger]);
    }
    
    if(self.stepInteger<self.formSteps.steps.count-1)
    {
        [submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
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
    
    NSString* nibName=@"";
    if (model.type==BaseFormTypeNormal||model.type==BaseFormTypeNormalUnit)
    {
        nibName=NSStringFromClass([TitleTextFieldTableViewCell class]);
    }
    else if(model.type==BaseFormTypeLargeField)
    {
        nibName=NSStringFromClass([TitleTextViewTableViewCell class]);
    }
    else if(model.type==BaseFormTypeTimePicker)
    {
        nibName=NSStringFromClass([TitleSingleSelectionTableViewCell class]);
    }
    
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

#pragma mark editing

-(void)formBaseTableViewCellWillBeginEditing:(FormBaseTableViewCell *)cell
{
    NSIndexPath* indexpath=[self.tableView indexPathForCell:cell];
    [self scrollToIndexPath:indexpath];
}

-(void)scrollToIndexPath:(NSIndexPath*)indexPath
{
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark submitform

-(void)submit
{
    NSString* str=[self.formSteps warningStringForStep:self.stepInteger];
    if (str.length>0) {
        [MBProgressHUD showErrorMessage:str];
    }
    if (self.stepInteger<self.formSteps.steps.count-1) {
        BaseFormTableViewController* nextPage=(BaseFormTableViewController*)[[[self class]alloc]init];
        nextPage.stepInteger=self.stepInteger+1;
        nextPage.formSteps=self.formSteps;
        [self.navigationController pushViewController:nextPage animated:YES];
    }
    else
    {
        [MBProgressHUD showSuccessMessage:@"最后一页了"];
        NSLog(@"%@",[self.formSteps parameters]);
    }
}

@end
