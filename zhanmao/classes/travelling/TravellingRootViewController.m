//
//  TravellingRootViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TravellingRootViewController.h"
#import "LargeImageBlackLabelTableViewCell.h"

@interface TravellingRootViewController ()

@end

@implementation TravellingRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LargeImageBlackLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"LargeImageBlackLabelTableViewCell"];
    
    [self setAdvertiseHeaderViewWithPicturesUrls:[NSArray arrayWithObjects:
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508838600421&di=657bb23fe8427c3b0bd101fe297214d2&imgtype=0&src=http%3A%2F%2Fwww.im4s.cn%2Ftrade%2Fuploads%2Fallimg%2F160606%2F456-160606114A6326.jpg",
                        @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1889566272,4112726323&fm=27&gp=0.jpg",
                        @"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViews

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }
    return 0.0001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LargeImageBlackLabelTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"LargeImageBlackLabelTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

@end
