//
//  GVUserDefaults+Properties.m
//  GVUserDefaults
//
//  Created by Kevin Renskers on 18-12-12.
//  Copyright (c) 2012 Gangverk. All rights reserved.
//

#import "GVUserDefaults+Properties.h"

@implementation GVUserDefaults (Properties)
@dynamic token;
@dynamic user_id;
@dynamic account;
@dynamic gender;
@dynamic birthday;
@dynamic weight;
@dynamic height;
@dynamic nickname;
@dynamic profile;
@dynamic avatar;
@dynamic fans;
@dynamic focus;
@dynamic collects;
@dynamic login_type;
@dynamic ad_version;
@dynamic app_version;
@dynamic user_phone;
@dynamic isjizhi;
@dynamic city;
@dynamic uuid;
@dynamic isWeChat;
@dynamic isQQ;
@dynamic isWeiBo;
@dynamic isGuzhu;
@dynamic g_id;

- (void)cleanUserData {
    
    self.token = nil;
    self.user_id = nil;
    self.nickname = nil;
    self.profile = nil;
    self.avatar = nil;
    self.fans = nil;
    self.focus = nil;
    self.collects = nil;
    self.login_type = nil;
    self.user_phone = nil;
    self.isjizhi = nil;
    self.gender = nil;
    self.birthday = nil;
    self.city = nil;
    self.login_type = nil;
    self.isWeChat = nil;
    self.isQQ = nil;
    self.isWeiBo = nil;
    self.isGuzhu = nil;
    self.g_id = nil;
}

@end
