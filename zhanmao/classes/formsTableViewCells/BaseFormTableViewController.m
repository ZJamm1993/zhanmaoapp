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
                             NSStringFromClass([TitleSelectionItemTableViewCell class]),
                             NSStringFromClass([TitleSelectionHeaderTableViewCell class])
                             , nil];
    for (NSString* nibName in nibsToRegister) {
        [self.tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    }
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    UIView* bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.tableView.frame.size.width, 64)];
    bottomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton* submitButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, bottomView.frame.size.width-20, bottomView.frame.size.height-20)];
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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark keyboards

-(void)keyboardShows:(NSNotification*)noti
{
    NSLog(@"%@",noti);
    
    //UIKeyboardFrameEndUserInfoKey;
    //UIKeyboardAnimationDurationUserInfoKey;
    //UIKeyboardAnimationCurveUserInfoKey;
    
    [self keyboardAnimationWithNotification:noti];
}

-(void)keyboardHides:(NSNotification*)noti
{
    NSLog(@"%@",noti);
    
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    NSString* nibName=[nibsToRegister objectAtIndex:(section+row)%nibsToRegister.count];
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:nibName forIndexPath:indexPath];
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
    
}

@end
