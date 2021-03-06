//
//  AppDelegate.m
//  caa
//
//  Created by xichao on 16/10/28.
//  Copyright © 2016年 xichao. All rights reserved.
//

#import "AppDelegate.h"
#import "JSONKit.h"
#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NotificationConfigure.h"
#import "IQKeyboardManager.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h> // 这里是iOS10需要用到的框架
#endif
static NSString * const JPUSHAPPKEY = @"b415106cea8b70ed3aabce2a"; // 极光appKey
static NSString * const channel = @"Publish channel"; // 固定的
#ifdef DEBUG // 开发

static BOOL const isProduction = TRUE; // 极光FALSE为开发环境

#else // 生产

static BOOL const isProduction = FALSE; // 极光TRUE为生产环境

#endif
static SystemSoundID shake_sound_male_id1 = 0;
static SystemSoundID shake_sound_male_id2 = 1;
@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    BOOL _goBackground;
}
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//播放器
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) NSInteger showTime;
@end
@implementation AppDelegate
//AppKey: b415106cea8b70ed3aabce2a
//Master Secret :c2105b3585b520daaf78b8f9

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if (![[user objectForKey:@"token"] isKindOfClass:[NSString class]]){
        LoginViewController * logVC  = [[LoginViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:logVC];
        self.window.rootViewController = nav;
        
    }else{
        TabBarViewController * tabVC = [[TabBarViewController alloc]init];
        self.window.rootViewController = tabVC;
    }
    
    [self.window makeKeyAndVisible];
    [user setObject:@[] forKey:@"city"];
    [user synchronize];
    /*
     *  键盘弹出事件
     */
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    // 注册apns通知
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) // iOS10
    {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) // iOS8, iOS9
    {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        
    }
    else // iOS7
    {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHAPPKEY channel:channel apsForProduction:isProduction advertisingIdentifier:nil];
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
   
    // Override point for customization after application launch.
    return YES;
}



- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 注册成功
    // 极光: Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
#pragma mark - iOS7: 收到推送消息调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // iOS7之后调用这个
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知");
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.0 || application.applicationState > 0)
    {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        [JPUSHService resetBadge];
        if ([[userInfo objectForKey:@"cmd"] isEqualToString:@"get_promotion"]){
            NSString *path = [[NSBundle mainBundle] pathForResource:@"get_promotion" ofType:@"caf"];
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id1);
                AudioServicesPlaySystemSound(shake_sound_male_id1);
            }
        }
        else if ([[userInfo objectForKey:@"cmd"] isEqualToString:@"use_promotion"]) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"use_promotion" ofType:@"caf"];
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id2);
                AudioServicesPlaySystemSound(shake_sound_male_id2);
                
            }
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    
    
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSMutableDictionary *dic = [content mj_JSONObject];
    NSLog(@"%@",dic);
    NSLog(@"%@ %@",[dic objectForKey:@"cmd"],[dic objectForKey:@"msg"]);
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if ([[dic objectForKey:@"cmd"] isEqualToString:@"promotion_get"]){
        NSArray * dataArr = [dic objectForKey:@"data"];
        for  ( int i = 0; i < dataArr.count ;i++){
            if ([[user objectForKey:@"userID"] isEqualToString:dataArr[i][@"user_id"]] ){
                
                NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"红包领取成功.mp3" ofType:nil];
                NSURL *url=[NSURL fileURLWithPath:urlStr];
                NSError *error=nil;
                //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
                _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
                //设置播放器属性
                _audioPlayer.numberOfLoops=0;//设置为0不循环
                [_audioPlayer play];
                
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
            }
        }
    }
    else if ([[dic objectForKey:@"cmd"] isEqualToString:@"promotion_use"]){
        if (![[user objectForKey:@"userID"] isEqualToString:@""]){
            NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"红包核销成功.mp3" ofType:nil];
            NSURL *url=[NSURL fileURLWithPath:urlStr];
            NSError *error=nil;
            //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
            _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
            //设置播放器属性
            _audioPlayer.numberOfLoops=0;//设置为0不循环
            [_audioPlayer play];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
            
        }
    }else{
        if ([[dic objectForKey:@"token"] isEqualToString:[user objectForKey:@"token"]]){
           
            LoginViewController * logVC  = [[LoginViewController alloc]init];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:logVC];
            self.window.rootViewController = nav;
            HYAlertView *alert = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:[dic objectForKey:@"msg"]  buttonTitles:@"确定", nil];
            [alert showInView:self.window completion:nil];
        }
    }
    
}
// ---------------------------------------------------------------------------------

#pragma mark - iOS10: 收到推送消息调用(iOS10是通过Delegate实现的回调)
#pragma mark- JPUSHRegisterDelegate
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
         [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        [JPUSHService resetBadge];
        if ([[userInfo objectForKey:@"cmd"] isEqualToString:@"get_promotion"]){
            NSString *path = [[NSBundle mainBundle] pathForResource:@"get_promotion" ofType:@"caf"];
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id1);
                AudioServicesPlaySystemSound(shake_sound_male_id1);
               
            }
        }
        else if ([[userInfo objectForKey:@"cmd"] isEqualToString:@"use_promotion"]) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"use_promotion" ofType:@"caf"];
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id2);
                AudioServicesPlaySystemSound(shake_sound_male_id2);
                
            }
        }

    }
    
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
         [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
        [JPUSHService resetBadge];
        if ([[userInfo objectForKey:@"cmd"] isEqualToString:@"get_promotion"]){
            NSString *path = [[NSBundle mainBundle] pathForResource:@"get_promotion" ofType:@"caf"];
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id1);
                AudioServicesPlaySystemSound(shake_sound_male_id1);
                //        AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
            }
        }
        else if ([[userInfo objectForKey:@"cmd"] isEqualToString:@"use_promotion"]) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"use_promotion" ofType:@"caf"];
            if (path) {
                //注册声音到系统
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_male_id2);
                AudioServicesPlaySystemSound(shake_sound_male_id2);
               
            }
        }
    }
    
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound);  // 系统要求执行这个方法
}
#endif

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //通知发送失败要返回的信息;
    NSLog(@"error = %@",error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    //进入后台
    
    _goBackground = YES;
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}
//- (void)controlTheTime
//{
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(controlTheTimeFnid:) userInfo:nil repeats:YES];
//}
//
//- (void)controlTheTimeFnid:(NSTimer *)time
//{
//    NSUserDefaults * user  = [NSUserDefaults standardUserDefaults];
//    if (![[user objectForKey:@"userID"] isEqualToString:@""]){
//        while (1) {
//            NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"红包领取成功.mp3" ofType:nil];
//            NSURL *url=[NSURL fileURLWithPath:urlStr];
//            NSError *error=nil;
//            //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
//            _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//            //设置播放器属性
//            _audioPlayer.numberOfLoops=100;//设置为0不循环
//            [_audioPlayer play];
//        };
//
//    }
//}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService resetBadge];

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"Refresh" object:nil];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   
}


@end
