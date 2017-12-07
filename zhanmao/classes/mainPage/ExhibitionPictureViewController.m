//
//  ExhibitionPictureViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionPictureViewController.h"
#import "PhotoSliderView.h"

@interface ExhibitionPictureViewController ()
{
    
}
@end

@implementation ExhibitionPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.pictureTitle;
    CGRect re=self.view.bounds;
    re.origin.y=-64;
    PhotoSliderView* php=[[PhotoSliderView alloc]initWithFrame:re];
//    php.images=[NSArray arrayWithObjects:
//                @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508838600421&di=657bb23fe8427c3b0bd101fe297214d2&imgtype=0&src=http%3A%2F%2Fwww.im4s.cn%2Ftrade%2Fuploads%2Fallimg%2F160606%2F456-160606114A6326.jpg",
//                @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1889566272,4112726323&fm=27&gp=0.jpg",
//                @"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
//    php.title=@"公路最速e理论";
    
    php.title=self.pictureTitle;
    php.images=self.images;
    
    [self.view addSubview:php];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
