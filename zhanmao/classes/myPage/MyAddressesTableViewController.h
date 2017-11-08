//
//  MyAddressEditTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"
#import "AddressModel.h"

@class MyAddressesTableViewController;

@protocol MyAddressesTableViewControllerDelegate <NSObject>

@optional
-(void)myAddressesTableViewController:(MyAddressesTableViewController*)controller didSelectedAddress:(AddressModel*)address;

@end

@interface MyAddressesTableViewController : BaseToolBarTableViewController

@property (nonatomic,weak) id<MyAddressesTableViewControllerDelegate> delegate;

@end
