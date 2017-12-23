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

@interface ProductWebDetailViewController ()<RentActionEditViewDelegate>
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
    
    UIButton* sub=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.bottomBgBounds.size.width-20, self.bottomBgBounds.size.height-20)];
    [sub setTitle:@"加入租赁车" forState:UIControlStateNormal];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
           
           if (success) {
               success(self.detailedModel);
           }
       } failure:^(NSError *error) {
           [MBProgressHUD showErrorMessage:@"加载失败"];
       }];
   }
}

@end
