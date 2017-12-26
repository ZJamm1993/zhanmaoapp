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
    PhotoSliderView* php;
    
    CGFloat bottomSafe;
}
@end

@implementation ExhibitionPictureViewController

#if XcodeSDK11
-(void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    if ([self.view respondsToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets est=[self.view safeAreaInsets];
            bottomSafe=est.bottom;
            
            CGRect re=[[UIScreen mainScreen]bounds];
            re.size.height=re.size.height-44-[[UIApplication sharedApplication]statusBarFrame].size.height-bottomSafe;
            php.frame=re;
            php.title=self.pictureTitle;
            php.images=self.images;
        } else {
            // Fallback on earlier versions
        }
    }
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.pictureTitle;
    self.view.backgroundColor=[UIColor blackColor];
    
    CGRect re=[[UIScreen mainScreen]bounds];
    re.size.height=re.size.height-44-[[UIApplication sharedApplication]statusBarFrame].size.height-bottomSafe;
    php=[[PhotoSliderView alloc]initWithFrame:re];
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
