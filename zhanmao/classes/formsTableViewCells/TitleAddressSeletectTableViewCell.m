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
    else
    {
        self.image.image=[UIImage imageNamed:@"addressBlue"];
    }
    
    if (model.accessoryObject) {
        AddressModel* add=model.accessoryObject;
        model.value=add.idd;
        if ([add isKindOfClass:[AddressModel class]]) {
            self.name.text=add.addressee;
            self.phone.text=add.phone;
            
//            self.address.text=add.address;
            NSString* pro=add.province;
            NSString* cit=add.city;
            NSString* dis=add.district;
            NSString* adr=add.address;
            if (pro.length==0) {
                pro=@"";
            }
            if (cit.length==0) {
                cit=@"";
            }
            if (dis.length==0) {
                dis=@"";
            }
            if (adr.length==0) {
                adr=@"";
            }
            self.address.text=[NSString stringWithFormat:@"%@%@%@%@",pro,cit,dis,adr];
            NSInteger count=self.model.combination_arr.count;
            for (NSInteger i=0;i<count;i++) {
                BaseFormModel* subModel=[self.model.combination_arr objectAtIndex:i];
                if (i==0)
                {
                    subModel.value=add.addressee;
                }
                else if(i==1)
                {
                    subModel.value=add.phone;
                }
                else if(i==2)
                {
                    subModel.value=add.province;
                }
                else if(i==3)
                {
                    subModel.value=add.city;
                }
                else if(i==4)
                {
                    subModel.value=add.district;
                }
                else if(i==5)
                {
                    subModel.value=add.address;
                }
            }
        }
    }
    
    self.textBg.hidden=model.value.length==0;
    self.placeHolder.hidden=!self.textBg.hidden;
}

-(void)myAddressesTableViewController:(MyAddressesTableViewController *)controller didSelectedAddress:(AddressModel *)address
{
    if (address) {
        self.model.accessoryObject=address;
        self.model.value=address.idd;
        
        NSInteger count=self.model.combination_arr.count;
        for (NSInteger i=0;i<count;i++) {
            BaseFormModel* subModel=[self.model.combination_arr objectAtIndex:i];
            if (i==0)
            {
                subModel.value=address.addressee;
            }
            else if(i==1)
            {
                subModel.value=address.phone;
            }
            else if(i==2)
            {
                subModel.value=address.province;
            }
            else if(i==3)
            {
                subModel.value=address.city;
            }
            else if(i==4)
            {
                subModel.value=address.district;
            }
            else if(i==5)
            {
                subModel.value=address.address;
            }
        }
        [self reloadModel];
    }
}

@end
