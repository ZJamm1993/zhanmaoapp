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
    timer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(countingDown) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [timer invalidate];
}

-(void)countingDown
{
    
}

@end
