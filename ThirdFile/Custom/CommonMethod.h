//
//  CommonMethod.h
//  PensionTreasure
//
//  Created by Simon on 16/7/4.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "BaseIBObject.h"


@interface CommonMethod : BaseIBObject
//1. 判断手机号码格式是否正确，利用正则表达式验证
+ (BOOL)isMobileNumer:(NSString *)mobileNum;

//2. 判断邮箱格式是否正确，利用正则表达式验证
+ (BOOL)isEamilAvailable:(NSString *)emailAl;

//3. 判断字符串中是否含有空格
+ (BOOL)isHaveSpaceInstring:(NSString *)string;

//4. 判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string;

//5. 判断字符串是否全部为数字
+ (BOOL)isPureInteger:(NSString *)string;

//6. 过滤一些特殊字符 只去除头尾的特殊字符【只是去除头和尾的特殊字符】
+ (NSString *)filterSpecialWithString:(NSString *)string;

//7. 磁盘总空间大小
+ (CGFloat )diskOfAllSizeMBytes;

//8. 磁盘可用空间大小
+ (CGFloat )diskOfFreeSizeMBytes;

//9. 处理输入框金额格式
+ (BOOL)CheckMoney:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

//10. 错误信息封装
+ (NSString *)showErrorMessage:(NSError *)error;

//11. 错误信息展示
+ (void)showToast:(NSError *)error;
+ (void)showToast1:(NSString *)msg;

//12. 输入框是否输入合法
+ (BOOL)userNameIsRightInputWithString:(NSString*)string;

//13. 创建32位的uuid
+ (NSString*)createUUID ;

+ (NSString*)getDateStringFromTimeInterval:(NSString*)timeIntervalString;
+ (NSString*)getTheDealTypeWithRemark:(NSString*)remark;

//15. 手势密码输入错误次数
+ (int)tryUnLockCount;
+ (void)setTryUnLockCount:(int)count;
+ (BOOL)isCachePassWord;

/*
  16. 格式化数字计算算法
         algorithmMode=Add        加
         algorithmMode=Subtract   减
         algorithmMode=Multiply   乘
         algorithmMode=Divide     除
 
 */
+ (NSString *)formattedDigitalComputingAlgorithm:(NSString *)algorithmMode firstNumber:(NSString *)firstNum secondNumber:(NSString *)secondNum;

+ (NSString*)NSNullOrNilToString:(NSString*)str;

//是否包含特殊字符
+ (BOOL)isIncludeSpecialCharact:(NSString *)str;

//随机选择number种不同的颜色
+ (NSArray *)selectColorWithNumber:(NSInteger)number;

+ (NSString*)stringValueIncrease:(NSString*)string;

+ (NSString*)stringValueDecrease:(NSString*)string;

+ (NSString *)switchWithString:(NSString *)string;
//CFCA
+ (NSString*)getCFCError:(NSString*)pErrorCode;
@end
