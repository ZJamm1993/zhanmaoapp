//
//  MyAboutUsViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/14.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyAboutUsViewController.h"
#import "MyPageHttpTool.h"

@interface MyAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;

@end

@implementation MyAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于我们";
    self.iconImage.layer.cornerRadius=10;
    self.iconImage.clipsToBounds=YES;
    [self refresh];
    // Do any additional setup after loading the view.
}

#pragma mark refresh

-(void)refresh
{
    NSString* version=[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    version=[NSString stringWithFormat:@"v%@",version];
    _versionLabel.text=version;
    [MyPageHttpTool getStandardConfigCache:YES success:^(NSDictionary *config) {
        if (config) {
            _emailLabel.text=[config valueForKey:@"site_admin_email"];
            //#warning  wechat ?
            _wechatLabel.text=[config valueForKey:@"gongzhonghao"];
            _websiteLabel.text=[config valueForKey:@"website"];
            [self.tableView reloadData];
        }
    }];
    [self.tableView reloadData];
}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==[tableView numberOfSections]-1) {
        return 34;
    }
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if (_emailLabel.text.length>0) {
                [[UIPasteboard generalPasteboard]setString:_emailLabel.text];
                [MBProgressHUD showSuccessMessage:@"已复制邮箱"];
            }
        }
        else if(indexPath.row==1)
        {
            if (_wechatLabel.text.length>0) {
                [[UIPasteboard generalPasteboard]setString:_wechatLabel.text];
                [MBProgressHUD showSuccessMessage:@"已复制微信公众号"];
            }
        }
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            if (_websiteLabel.text.length>0) {
                [[UIPasteboard generalPasteboard]setString:_websiteLabel.text];
                [MBProgressHUD showSuccessMessage:@"已复制官网"];
            }
        }
    }
}

@end
