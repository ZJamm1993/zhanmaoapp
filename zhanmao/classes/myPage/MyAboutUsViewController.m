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

-(void)refresh
{
    NSString* version=[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    version=[NSString stringWithFormat:@"v%@",version];
    _versionLabel.text=version;
    [MyPageHttpTool getStandardConfigCache:YES success:^(NSDictionary *config) {
        if (config) {
            _emailLabel.text=[config valueForKey:@"site_admin_email"];
#warning  wechat ?
            _websiteLabel.text=[config valueForKey:@"website"];
            [self.tableView reloadData];
        }
    }];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    
}

@end
