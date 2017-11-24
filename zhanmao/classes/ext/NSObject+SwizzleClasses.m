//
//  NSObject+SwizzleClasses.m
//  yangsheng
//
//  Created by Macx on 2017/8/22.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSObject+SwizzleClasses.h"

#import "UIImageView+WebCache.h"

@implementation NSObject (SwizzleClasses)

@end

@implementation UITableView(SwizzleClasses)

+(void)load
{
    NSLog(@"UITableView Class Load");
    NSLog(@"swizzle reloaddata");
    [[self class]jr_swizzleMethod:@selector(reloadData) withMethod:@selector(myReloadData) error:nil];
}

-(void)myReloadData
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"tableView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UITableViewReloadDataNotification object:nil userInfo:dic];
    [self myReloadData];
//    if(self.style==UITableViewStyleGrouped)
//    {
//        self.backgroundColor=gray_9;
//    }
    self.separatorColor=gray_8;
    self.showsVerticalScrollIndicator=NO;
}

@end

@implementation UICollectionView(SwizzleClasses)

+(void)load
{
    NSLog(@"UICollectionView Class Load");
    NSLog(@"swizzle reloadsections");
    [[self class]jr_swizzleMethod:@selector(reloadSections:) withMethod:@selector(myReloadSections:) error:nil];
    
}

-(void)myReloadSections:(NSIndexSet*)sections
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"collectionView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UICollectionViewReloadSectionsNotification object:nil userInfo:dic];
    [self myReloadSections:sections];
    self.backgroundColor=gray_9;
}

@end

@implementation UIViewController(SwizzleClasses)

+(void)load
{
    NSLog(@"UIViewController Class Load");
    NSLog(@"swizzle viewdidload");
    [[self class]jr_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(myViewDidLoad) error:nil];
}

-(void)myViewDidLoad
{
    
    [self myViewDidLoad];
    NSLog(@"\"%@\" view did load",NSStringFromClass([self class]));
    BOOL isNotUIViewController=![self isMemberOfClass:[UIViewController class]];
    BOOL isNotNavgationController=![self isKindOfClass:[UINavigationController class]];
    BOOL isNotTabbarController=![self isKindOfClass:[UITabBarController class]];
    
//    if (@available(iOS 11.0, *)) {
//        if ([self respondsToSelector:@selector(tableView)]) {
//            UITableView* tabl=[self performSelector:@selector(tableView)];
//            tabl.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    BOOL isChecked=isNotUIViewController&&isNotNavgationController&&isNotTabbarController;
    if (isChecked) {
        
    }
}

@end

@implementation UIImageView(SwizzleClasses)

+(void)load
{
    NSLog(@"UIImageView Class Load");
//    NSLog(@"swizzle sd_setImageWithURL");
//    [[self class]jr_swizzleMethod:@selector(sd_setImageWithURL:) withMethod:@selector(my_sd_setImageWithURL:) error:nil];
}

-(void)my_sd_setImageWithURL:(NSURL*)url
{
    NSString* urlstr=[url absoluteString];
    NSLog(@"load image: %@",urlstr);
    [self my_sd_setImageWithURL:url];
}

@end

@implementation UIScrollView(SwizzleClasses)



@end

