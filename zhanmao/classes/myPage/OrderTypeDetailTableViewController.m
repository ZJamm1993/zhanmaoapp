//
//  OrderTypeDetailTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/21.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeDetailTableViewController.h"

@interface OrderTypeDetailTableViewController ()
{
    NSTimer* timer;
}
@end

@implementation OrderTypeDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countingDown) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orderTypeChangedNotification:) name:OrderTypeStatusChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

-(void)countingDown
{
    
}

-(void)orderTypeChangedNotification:(NSNotification*)noti
{
    NSDictionary* us=noti.userInfo;
    OrderTypeBaseModel* model=[us valueForKey:@"order"];
    [self orderStatusChanged:model];
}

-(void)orderStatusChanged:(OrderTypeBaseModel *)orderModel
{
    NSLog(@"order status changed: %@",orderModel);
}

@end
