//
//  TitleAddressSeletectTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/15.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleAddressSeletectTableViewCell.h"
#import "MyAddressesTableViewController.h"

@interface TitleAddressSeletectTableViewCell()<MyAddressesTableViewControllerDelegate>
@end

@implementation TitleAddressSeletectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        MyAddressesTableViewController* seleAdd=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyAddressesTableViewController"];
        seleAdd.delegate=self;
        
        if ([self.delegate respondsToSelector:@selector(formBaseTableViewCell:shouldPushViewController:)]) {
            [self.delegate formBaseTableViewCell:self shouldPushViewController:seleAdd];
        }
//        UITabBarController* topTap=(UITabBarController*)[[[UIApplication sharedApplication]keyWindow]rootViewController];
//        if ([topTap isKindOfClass:[UITabBarController class]]) {
//            UINavigationController* topNav=[topTap selectedViewController];
//            if ([topNav isKindOfClass:[UINavigationController class]]) {
//                [topNav pushViewController:seleAdd animated:YES];
//            }
//        }
    }
    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    self.placeHolder.text=model.hint;
    self.image.image=nil;
    if ([model.name isEqualToString:@"寄"]) {
        self.image.image=[UIImage imageNamed:@"send"];
    }
    else  if ([model.name isEqualToString:@"收"]) {
        self.image.image=[UIImage imageNamed:@"recevice"];
    }
    
    if (model.accessoryObject) {
        AddressModel* add=model.accessoryObject;
        if ([add isKindOfClass:[AddressModel class]]) {
            self.name.text=add.addressee;
            self.phone.text=add.phone;
            self.address.text=add.address;
        }
    }
    
    self.textBg.hidden=model.value.length==0;
}

-(void)myAddressesTableViewController:(MyAddressesTableViewController *)controller didSelectedAddress:(AddressModel *)address
{
    if (address) {
        self.model.accessoryObject=address;
        self.model.value=address.idd;
        [self reloadModel];
    }
}

@end
