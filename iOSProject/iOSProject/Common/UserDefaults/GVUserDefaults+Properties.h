//
//  GVUserDefaults+Properties.h
//  GVUserDefaults
//
//  Created by Kevin Renskers on 18-12-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

#import "GVUserDefaults.h"

@interface GVUserDefaults (Properties)
// !!!: 用户信息
/**
 登录授权码
 */
@property (nonatomic, copy) NSString *token;
// 游客id
@property (nonatomic, copy) NSString *uuid;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic,copy) NSString *account;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic,copy) NSString *height;

@property (nonatomic,copy) NSString *weight;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic , copy) NSString *profile;

@property (nonatomic , copy) NSString *avatar;

@property (nonatomic, copy) NSString *fans;

@property (nonatomic, copy) NSString *focus;

@property (nonatomic, copy) NSString *collects;

@property (nonatomic, copy) NSString *user_phone;

@property (nonatomic, copy) NSString *city;

@property (nonatomic , copy) NSString *isjizhi;

@property (nonatomic , copy) NSString *isWeChat;

@property (nonatomic , copy) NSString *isQQ;

@property (nonatomic , copy) NSString *isWeiBo;

@property (nonatomic , copy) NSString *isGuzhu;

@property (nonatomic , copy) NSString *g_id;
/**
 用户登录方式
 0 验证码登录
 1 密码登录
 2 第三方登录
 */
@property (nonatomic, assign) NSString *login_type;

// !!!: ----- Other -----
/**
 广告版本
 */
@property (nonatomic , copy) NSString *ad_version;

/**
 app 版本
 */
@property (nonatomic , copy) NSString *app_version;

/**
 退出登录  注意
 */
- (void)cleanUserData;
@end
