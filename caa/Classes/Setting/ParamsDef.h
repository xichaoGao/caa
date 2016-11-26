//
//  ParamsDef.h
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#ifndef ParamsDef_h
#define ParamsDef_h
#define messageStr  @"7e6e50cbc1838fc9f6030a60ce1e4c2b"

#define KTest @"Test/testPush";
#define BASEURL @"http://admin.bjyfkj.net/api.php/"
#define kRegister @"User/addUserByPhone"//注册
#define kLogin @"User/userLogin"//登录
#define kSendVefification @"User/sendCode"//发送验证码
#define kCheckVerification @"User/checkCode"//检测短信验证码
#define kSetNewPassWord @"User/resetPWD"//设置新的密码

#define KAdsMsg @"Ads/index"//首页
#define KGetWxUser @"Ads/getWxUserPromotion"//微信用户
#define KGetCity @"Ads/getCities"//城市列表
#define KGetUrban @"Ads/getDistricts"//城市列表
#define KGetArea @"Ads/getArea"//商圈
#define KGetTime @"Ads/getSchedule"//时间
#define KGetEq @"Ads/getDevicesBySchedule"//设备
#define KSubmitAd @"Ads/submitAds"//发布广告
#define KCancelAd @"Ads/cancelAds"//发布广告

#define KLogout @"Member/userLogout"//退出登录
#define KSetNickName @"Member/setNickname"//修改昵称
#define KSetHeadImg @"Member/setHeadIMG"//修改头像
#define KGetAdsList @"Member/getMyAdsList"//广告列表
#define KGetAdsDet @"Member/getAdsDetail"//广告详情
#define KGetMineRelease @"Ads/myAds"//我的发布

#endif /* ParamsDef_h */
