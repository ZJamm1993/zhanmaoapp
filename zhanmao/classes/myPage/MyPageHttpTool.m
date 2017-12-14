//
//  MyPageHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageHttpTool.h"

@implementation MyPageHttpTool

+(void)postNewAddressEdit:(BOOL)edit param:(NSDictionary *)param success:(void (^)(BOOL,NSString*,NSString*))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/add"];
    if (edit) {
        str=[ZZUrlTool fullUrlWithTail:@"/User/Address/edit_post"];
    }
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        NSString* idd=[[responseObject valueForKey:@"data"]description];
        if (success) {
            success(code,msg,idd);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription,@"");
        }
    }];
}

+(void)postDefaultAddressId:(NSString*)addid token:(NSString*)token success:(void(^)(BOOL result,NSString* msg))success
{
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setValue:addid forKey:@"id"];
    [param setValue:token forKey:@"access_token"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/setdefault"];
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)postDeleteAddressId:(NSString *)addid token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setValue:addid forKey:@"id"];
    [param setValue:token forKey:@"access_token"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/del"];
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)getMyAddressesToken:(NSString*)token cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/index"];
    if (token.length==0) {
        if (failure) {
            failure(nil);
        }
        return;
    }
    NSDictionary* par=[NSDictionary dictionaryWithObject:token forKey:@"access_token"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* addreDic in data) {
            AddressModel* ad=[[AddressModel alloc]initWithDictionary:addreDic];
            [arr addObject:ad];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)uploadAvatar:(UIImage *)avatar token:(NSString *)token success:(void (^)(NSString *))success
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Profile/avatar_upload"];
        
        if (token.length==0||avatar==nil) {
            if (success) {
                success(@"");
            };
            return;
        }
        
        NSDictionary* par=[NSDictionary dictionaryWithObject:token forKey:@"access_token"];
        CGSize size=CGSizeMake(600,600);
        UIGraphicsBeginImageContext(CGSizeMake(size.width,size.height));
        [avatar drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(scaledImage, 0.5);
        [self uploadImage:imageData url:str params:par success:^(NSDictionary *dict) {
            NSString* data=[dict valueForKey:@"data"];
            if (success) {
                success(data);
            }
        } failure:^(NSError *err) {
            if (success) {
                success(@"");
            }
        }];
//    });
    
}

+(void)getPersonalInfoToken:(NSString *)token success:(void (^)(UserModel *,NSInteger))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Profile/show_info"];
    if (token.length==0) {
        if(success)
        {
            success(nil,-1);
        }
        return;
    }
    NSDictionary* par=[NSDictionary dictionaryWithObject:token forKey:@"access_token"];
    
    [self get:str params:par usingCache:NO success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        UserModel* mo=[[UserModel alloc]initWithDictionary:data];
        NSInteger code=dict.code;
        if (success) {
//            if (data.count>0) {
//                mo.access_token=token;
                success(mo,code);
//            }
//            else
//            {
//                success(nil);
//            }
        }
    } failure:^(NSError *err) {
        if (success) {
            success(nil,-1);
        }
    }];
}

+(void)postPersonalInfo:(NSDictionary *)params success:(void (^)(BOOL,NSString*))success
{
    NSMutableDictionary* pp=[NSMutableDictionary dictionaryWithDictionary:params];
    
    // fake
    if ([pp valueForKey:@"province"]) {
        [pp setValue:@" " forKey:@"province"];
    }
    if ([pp valueForKey:@"city"]) {
        [pp setValue:@" " forKey:@"city"];
    }
    if ([pp valueForKey:@"district"]) {
        [pp setValue:@" " forKey:@"cdistrictity"];
    }
    if ([pp valueForKey:@"address"]) {
        [pp setValue:@" " forKey:@"address"];
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Profile/edit_post"];
    
    [self post:str params:pp success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)getCodeWithMobile:(NSString *)mobile success:(void (^)(BOOL,NSString*))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Register/getmobilenum"];
    [self post:str params:[NSDictionary dictionaryWithObject:mobile forKey:@"mobile"] success:^(NSDictionary *responseObject) {
        NSString* msg=[responseObject valueForKey:@"message"];
        NSLog(@"msg:%@",msg);
        
        if (success) {
            if (responseObject.code==0) {
                success(YES,msg);
                //#warning 不要告诉我验证码
                //                [MBProgressHUD showSuccessMessage:msg];
            }
            else
            {
                success(NO,msg);
            }
        }
    } failure:^(NSError *error) {
        success(NO,@"");
    }];
}

+(void)loginUserWithMobile:(NSString *)mobile code:(NSString *)code success:(void (^)(NSString*,BOOL, NSString*))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Login/dologin"];
    
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:mobile forKey:@"mobile"];
    [p setValue:code forKey:@"code"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        NSDictionary* data=[responseObject valueForKey:@"data"];
        NSString* token=[data valueForKey:@"access_token"];
        BOOL newUser=[[data valueForKey:@"newuser"]boolValue];
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(token,newUser,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil,NO,BadNetworkDescription);
        }
    }];

}

+(void)postFeedbackContent:(NSString *)content contact:(NSString *)contact token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Freeback/add_post"];
    NSMutableDictionary* p=[NSMutableDictionary dictionary];
    
    [p setValue:contact forKey:@"contact"];
    [p setValue:content forKey:@"post_content"];
    [p setValue:token forKey:@"access_token"];
    
    [self post:str params:p success:^(NSDictionary *responseObject) {
        BOOL result=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(result,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)getHelpCenterListPage:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary* par=[self pageParamsWithPage:page size:pagesize];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Help/index"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            BaseModel* mo=[[BaseModel alloc]initWithDictionary:dic];
            [res addObject:mo];
        }
        if (success) {
            success(res);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getStandardConfigCache:(BOOL)cache success:(void (^)(NSDictionary *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Portal/Index/getconfig"];
    
    [self get:str params:nil usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        if (success) {
            success(data);
        }
    } failure:^(NSError *err) {
        if (success) {
            success(nil);
        }
    }];
}

@end
