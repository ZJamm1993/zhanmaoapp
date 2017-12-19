//
//  UserModel.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UserModel.h"

#define UserKey @"CW5QPB0hXYfXt3zY8QKLI8ahj95yMPdF"
#define UserPasswordKey @"CW5QPB0hXYfXt3zY8QK99I8ahj95yMPdF"
#define UserTokenKey @"CW5QrB0hXYfXt3zY8QK99I8ahj95yMPdF"

@implementation UserModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
//        _access_token=[dictionary valueForKey:@"access_token"];
        
        _user_nicename=[dictionary valueForKey:@"user_nicename"];
        _avatar=[dictionary valueForKey:@"avatar"];
        _mobile=[dictionary valueForKey:@"mobile"];
        _user_email=[dictionary valueForKey:@"user_email"];
        _position=[dictionary valueForKey:@"position"];
        _idd=[dictionary valueForKey:@"id"];
    }
    
//    if (_access_token.length==0) {
//        return nil;
//    }
    
    return self;
}

-(BOOL)isNullUser
{
    BOOL nulName=_user_nicename.length==0;
    BOOL nulAvatar=_avatar.length==0;
    BOOL nulMobile=_mobile.length==0;
    BOOL nulEmail=_user_email.length==0;
    BOOL nulPosition=_position.length==0;
    
    return nulName&&nulAvatar&&nulMobile&&nulEmail&&nulPosition;
}

+(NSString*)token
{
//    #warning test user token
#if DEBUG
    return @"123";
#endif
    NSString* to=[[NSUserDefaults standardUserDefaults]valueForKey:UserTokenKey];
    return to;
}

+(void)saveToken:(NSString *)token
{
    if (token.length==0) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:UserTokenKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setValue:token forKey:UserTokenKey];
    }
}

+(void)saveUser:(UserModel *)user
{
    if (user==nil) {
        [self deleteUser];
        return ;
    }
//    if (user.access_token.length==0) {
//        return;
//    }
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    
//    [d setValue:user.access_token forKey:@"access_token"];
    
    [d setValue:user.user_nicename forKey:@"user_nicename"];
    [d setValue:user.avatar forKey:@"avatar"];
    [d setValue:user.mobile forKey:@"mobile"];
    [d setValue:user.user_email forKey:@"user_email"];
    [d setValue:user.position forKey:@"position"];
    [d setValue:user.idd forKey:@"id"];
    
    NSData* data=[NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:nil];
    
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:UserKey];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:UserInfoDidUpdateNotification object:nil];
}

+(instancetype)getUser
{
//#warning test user token
//    
//    UserModel* testUser=[[UserModel alloc]init];
//    testUser.access_token=@"123";
//    return testUser;
    
    NSData * data=[[NSUserDefaults standardUserDefaults]valueForKey:UserKey];
    if (![data isKindOfClass:[NSData class]]) {
        [self deleteUser];
        return nil;
    }
    if (data.length==0) {
        return nil;
    }
    NSDictionary* d=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    UserModel* user=[[UserModel alloc]initWithDictionary:d];
    NSLog(@"%@",d);

    return user;
}

-(NSString*)cartId
{
    return self.idd;
}

+(void)deleteUser
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UserKey];
    [[NSNotificationCenter defaultCenter]postNotificationName:UserInfoDidUpdateNotification object:nil];
}

+(NSString*)getPassword
{
    NSData* data=[[NSUserDefaults standardUserDefaults]valueForKey:UserPasswordKey];
    if (![data isKindOfClass:[NSData class]]) {
        [self deletePassword];
        return nil;
    }
    if (data.length==0) {
        return nil;
    }
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return str;
}

+(void)savePassword:(NSString *)password
{
    if (password.length==0) {
        return;
    }
    NSData* data=[password dataUsingEncoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults]setValue:data forKey:UserPasswordKey];
}

+(void)deletePassword
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:UserPasswordKey];
}

@end
