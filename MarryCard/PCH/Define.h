//
//  Define.h
//  InternetBanking
//
//  Created by Simon on 16/6/12.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#ifndef Define_h
#define Define_h

/*
 KIT
 */
#define kNFGSDKErrorDomain           @"kNFGSDKErrorDomain"

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")


/*
 缓存相关
 */

#define GESTUREPASSWORD  @"gesturePassWorld"

/*
 项目组有用的宏定义
 */
//  定义 appdeleagte
#define KAPPDELEGATE ((AppDelegate*)([UIApplication sharedApplication].delegate))
// 防止崩溃
#define NOTNIL(v) (v?v:@"")
//获取图片
#define IMGNAMEED(_imgName) [UIImage imageNamed:_imgName]
// 导航字体
#define         TEXT_FONTNAME                   @"Heiti SC"
// 输入框过滤
#define MAYUSERDCHARACTER @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@_."
//网络请求
#define HTTPMANAGER   [NFGHTTPManager manager]

/*
 适配相关
*/
#define kFSCREEN_FREAM [UIScreen mainScreen].applicationFrame

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width//设备屏幕宽度

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height//设备屏幕高度

//weakself
#define ws(object) __weak typeof (object) weakSelf = object


//NSLog
#ifdef DEBUG
#define NSLog(format, ...) do { \
fprintf(stderr, "<%s : %d> %s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__); \
fprintf(stderr, "-----------------------------------------------------------\n"); \
} while (0)
#else
#define NSLog(format, ...)
#endif

#define KErrorCode @"errorCode"
#define KErrorMessage @"errorMessage"

/*********************************************开发四部*****************************************************/
typedef NS_ENUM(NSInteger,UIPageType){//页面类型
    UIPageTypeDefault,
    UIPageTypeSpecial
};

// 馆类型
typedef NS_ENUM(NSUInteger,pavilionType)
{
    artGallery = 0,
    audioLibrary,
    culturalCenter,
    historyMuseum
    
    
};
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

/********************************************************************************************************/



//禁止复制粘贴宏定义

#define Forbiddens  314


//16进制颜色
#define UIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#endif /* Define_h */
