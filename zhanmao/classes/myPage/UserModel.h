//
//  UserModel.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,UserType)
{
    UserTypeNormal=3,
    UserTypeDealer=2,
};

@interface UserModel : NSObject

+(void)saveUser:(UserModel*)user;
+(instancetype)getUser;
+(void)deleteUser;

+(NSString*)getPassword;
+(void)savePassword:(NSString*)password;
+(void)deletePassword;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* mobile;
@property (nonatomic,strong) NSString* user_nicename;
@property (nonatomic,strong) NSString* user_login;
@property (nonatomic,strong) NSString* access_token;
@property (nonatomic,strong) NSString* avatar;
@property (nonatomic,assign) UserType type;

@end
