//
//  ViewController.h
//  GoPushforIOS
//
//  Created by cqwange on 14-5-14.
//  Copyright (c) 2014年 BOCOP. All rights reserved.
//  Version 2.3

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

typedef NS_ENUM(NSInteger, kPushType)
{
    kPushDistribution,
    kPushDeveloper
};

@protocol PushManagerDelegate <NSObject>

#pragma - mark PushManagerDelegate
/*
 *在启动消息推送服务之前，需要实现PushManager的代理，并实现代理方法
 *三个必须实现的代理方法分别是为传递私有、群发、组发消息，都是以数组方式返回，数组中每一个元素是一个字符串，即消息内容
 *代理方法中可选的代理方式是当推送服务发现前台更改了用户而用以通知前台页面的，前台页面可以根据该通知刷新相应的内容
 */
@required
- (void)privateNotificationFromServer:(NSArray *)messageArr;
- (void)publicNotificationFromServer:(NSArray *)messageArr;
- (void)groupNotificationFromServer:(NSArray *)messageArr;
@optional
- (void)numofCount:(NSInteger)count Type:(NSInteger)nType;
@end

/*
 *LOGINOUTNSNOTIFICATION=@"loginOutNsnotification" 另一台设备上登录当前账号的通知，调用需添加观察者
 */
extern NSString *const LOGINOUTNSNOTIFICATION;

@interface PushManager : NSObject

#pragma mark - Class Methods
+ (void)registerForRemoteNotificationTypes:(NSUInteger)types
                                categories:(NSSet *)categories;  // 注册APNS类型
/**
 *  APNS消息处理返回
 *
 *  @param handle
 *  @param userInfo 返回消息字典
 *  @param type     消息类型(0 - private,1 - public,2 - group)
 *  @param pushServicecContinueReceive (apns收到的消息，GCDAsyncSocket是否继续接受)
 */
+ (void)apnsRemoteNotificationCompletionHandler:(void (^)(NSDictionary *userInfo,NSInteger type))handle
                    pushServicecContinueReceive:(BOOL)receive;
+ (void)setupWithOption:(NSDictionary *)launchingOption;         // 初始化
+ (void)registerDeviceToken:(NSData *)deviceToken;               // 向服务器上报Device Token
+ (void)handleRemoteNotification:(NSDictionary *)remoteInfo;     // 处理收到的APNS消息处理

/*
  delegate           :代理
  m_pClientKey       :当前应用程序在中银开放平台上注册的ClientKey
  m_pClientSecret    :当前应用程序在中银开放平台上注册的ClientKey对应的ClientSecret
  m_personID         :当前用户标识
  m_language         :当前app支持的语言种类，目前支持（CN（简体中文）,TW(繁体中文),EN（英语））,默认简体中文
  isNeedLog          :是否需要日志，默认为YES
  isServerOn         :用以表示推送服务是否启动，需要手动付值。当用户启动或关闭服务时需要重新付值
  pushType           :用以表示当前推送连接服务器地址(默认为kPushDistribution类型)
  connectedOnError   :连接失败原因
  connectedOnSuccess :连接成功
 */
@property (nonatomic, assign  ) id <PushManagerDelegate> delegate;
@property (nonatomic, copy    ) NSString            * m_pClientKey;
@property (nonatomic, copy    ) NSString            * m_pClientSecret;
@property (nonatomic, readonly) NSString            * m_personID;
@property (nonatomic, copy    ) NSString            * m_language;
@property (nonatomic, assign  ) BOOL                isNeedLog;
@property (nonatomic, assign  ) BOOL                isServerOn;
@property (nonatomic, assign  ) enum kPushType      pushType;
@property (nonatomic, copy    ) void(^connectedOnError)(NSError *error);
@property (nonatomic, copy    ) void(^connectedOnSuccess)();


#pragma - mark 基本功能

/*
  push_Url  :推送服务器域名 (默认@"http:openapi.boc.cn:80")
 */
- (instancetype)initWithPushUrl:(NSString *)pushUrl;

/*
  启动推送服务
*/
- (void)startPushService;

/*
 关闭推送服务(服务器不清除当前用户Device Token)
 */
- (void)stopPushService;


/*
关闭推送服务,服务器置空当前用户Device Token
 */
- (void)stopPushServiceCleanCurrentUserID;

/*
 设置用户的uid
*/
- (void)setPersonID:(NSString *)personid;

/*
 连接状态
 */
-(BOOL)isconnected;

@end
