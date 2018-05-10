//
//  ProductWebDetailViewController.m
//  zhanmao
//
//  Created by bangju on 2017/11/22.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ProductWebDetailViewController.h"
#import "MyLoginViewController.h"
#import "RentCartTableViewController.h"
#import "ProductCreateOrderTableViewController.h"
#import "RentActionEditView.h"
#import "ImageBadgeBarButtonItem.h"
#import "ZZPayTool.h"
#import "PhotoSliderView.h"

@interface ProductWebDetailViewController ()<RentActionEditViewDelegate,UIWebViewDelegate>
{
}
@property (nonatomic,strong) RentProductModel* detailedModel;
@end

@implementation ProductWebDetailViewController

- (void)viewDidLoad {
    
    [self.params setValue:@"1" forKey:@"html"];
    self.url=[HTML_GoodsShowDetail urlWithMainUrl];
    self.idd=self.goodModel.idd.integerValue;
    [super viewDidLoad];
    
    [self getDetailGoodModel:nil];
    
    [self resetBottonView];
    
    self.title=@"产品详情";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [RentHttpTool getRentCartsCountSuccess:^(NSInteger count) {
        ImageBadgeBarButtonItem* cartItem=[ImageBadgeBarButtonItem itemWithImageName:@"cart" count:count target:self selector:@selector(cartItemClicked)];
        self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:cartItem, nil];
    } userid:[UserModel getUser].cartId failure:nil];
    
}

- (void)resetBottonView
{
    if (self.detailedModel) {
        self.goodModel=self.detailedModel;
    }
    UIButton* sub=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.bottomBgBounds.size.width-20, self.bottomBgBounds.size.height-20)];
    [sub setTitle:@"加入租赁车" forState:UIControlStateNormal];
    if (self.goodModel.is_sale) {
        [sub setTitle:@"加入购物车" forState:UIControlStateNormal];
    }
    sub.backgroundColor=_mainColor;
    [sub setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sub setImage:[UIImage imageNamed:@"cartSmall"] forState:UIControlStateNormal];
    [sub setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [sub addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    [sub.layer setCornerRadius:4];
    [sub.layer setMasksToBounds:YES];
    
    UIView* subBg=[[UIView alloc]initWithFrame:self.bottomBgBounds];
    [subBg addSubview:sub];
    self.bottomView=subBg;
}

#pragma mark webview delegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /*
     http://zhanmao.bangju.com//themes/simplebootx/Mall/theImageUrl=http://zhanmao.bangju.com/data/upload/mall/20180321/5ab230a176f87.jpg
     */
    NSString* url=[[request URL]absoluteString];
    if ([url containsString:@".jpg"]) {
        NSString* imgUrl=[[url componentsSeparatedByString:@"="]lastObject];
        UINavigationController* photoNav=[PhotoSliderViewController navgationControllerWithPhotoSlider:^(PhotoSliderViewController *sliderController) {
            sliderController.images=[NSArray arrayWithObject:imgUrl];
        }];
        [self presentViewController:photoNav animated:YES completion:nil];
        return NO;
    }
    if ([super respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

#pragma mark actions

-(void)cartItemClicked
{
    //    ImageBadgeBarButtonItem* cartItem=[ImageBadgeBarButtonItem itemWithImageName:@"a" count:arc4random()%120 target:self selector:@selector(cartItemClicked)];
    //    self.navigationItem.rightBarButtonItem=cartItem;
    
    RentCartTableViewController* rent=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"RentCartTableViewController"];
    [self.navigationController pushViewController:rent animated:YES];
}

-(void)addToCart:(UIButton*)button
{
    //    RentCartTableViewController* cart=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"RentCartTableViewController"];
    //    [self.navigationController pushViewController:cart animated:YES];
    [button setEnabled:NO];
    [self getDetailGoodModel:^(RentProductModel *model) {
        RentActionEditView* action=[RentActionEditView defaultView];
        action.delegate=self;
        RentCartModel* car=[[RentCartModel alloc]init];
        car.product=self.detailedModel;
        car.count=1;
//        car.days=1;
        action.cartModel=car;
        [action showWithBottomInset:self.bottomSafeInset];
        
        if (self.goodModel.is_sale) {
            [action.addToCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
            [action.rentNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        }
    }];
    [self performSelector:@selector(reEnableButton:) withObject:button afterDelay:1];
}

#pragma mark rentactioneditviewdelegate

-(void)rentActionEditViewAddToRentCart:(RentCartModel *)cartModel
{
    if ([UserModel token].length==0) {
        [MBProgressHUD showErrorMessage:AskToLoginDescription];
        [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
        return;
    }
    if (cartModel) {
        [RentHttpTool addRentCarts:[NSArray arrayWithObject:cartModel] userid:[UserModel getUser].cartId success:^(BOOL result) {
            if(result)
            {
                RentCartTableViewController* rent=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"RentCartTableViewController"];
                [self.navigationController pushViewController:rent animated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

-(void)rentActionEditViewRentNow:(RentCartModel *)cartModel
{
//    UIAlertController* alert=[ZZPayTool testPayingAlertController];
//    [self presentViewController:alert animated:YES completion:nil];
    if (!cartModel) {
        return;
    }
    if ([UserModel token].length==0) {
        [MBProgressHUD showErrorMessage:AskToLoginDescription];
        [self.navigationController pushViewController:[MyLoginViewController loginViewController] animated:YES];
        return;
    }
    
    ProductCreateOrderTableViewController* rent=[[UIStoryboard storyboardWithName:@"OnlineRent" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductCreateOrderTableViewController"];
    rent.cartObjects=[NSArray arrayWithObject:cartModel];
    [self.navigationController pushViewController:rent animated:YES];
}

-(void)reEnableButton:(UIButton*)button
{
    button.enabled=YES;
}

-(void)getDetailGoodModel:(void(^)(RentProductModel* model))success
{
    
    if (self.detailedModel) {
        [MBProgressHUD hide];
        if (success) {
            success(self.detailedModel);
        }
    }
   else
   {
       [MBProgressHUD showProgressMessage:@""];
       [RentHttpTool getGoodDetailById:self.goodModel.idd cached:NO success:^(RentProductModel *result) {
           [MBProgressHUD hide];
           if(result.idd.length==0)
           {
               [MBProgressHUD showErrorMessage:@"商品不存在"];
               return;
           }
           self.detailedModel=result;
           [self resetBottonView];
           if (success) {
               success(self.detailedModel);
           }
       } failure:^(NSError *error) {
           [MBProgressHUD showErrorMessage:@"加载失败"];
       }];
   }
}

@end
