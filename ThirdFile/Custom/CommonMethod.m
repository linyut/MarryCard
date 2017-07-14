//
//  CommonMethod.m
//  PensionTreasure
//
//  Created by Simon on 16/7/4.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import "CommonMethod.h"
#import "MBProgressHUD.h"

@implementation CommonMethod

+ (BOOL)isMobileNumer:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL)isEamilAvailable:(NSString *)emailAl
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAl];
}

+ (BOOL)isHaveSpaceInstring:(NSString *)string
{
    NSRange _range = [string rangeOfString:@" "];
        if (_range.location != NSNotFound) {
            return YES;
        }else {
            return NO;
        }
}

+ (BOOL)isHaveChineseInString:(NSString *)string
{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isPureInteger:(NSString *)string
{
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSInteger val;
    return [scanner scanInteger:&val] && [scanner isAtEnd];
}

+ (NSString *)filterSpecialWithString:(NSString *)string
{
    // 定义一个特殊字符的集合
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:
                           @"@／：；: ;（）?「」＂、[]{}#%-*+=_|~＜＞$?^?'@#$%^&*()_+'"];
    // 过滤字符串的特殊字符
    NSString *newString = [string stringByTrimmingCharactersInSet:set];
    return newString;
}

+ (CGFloat )diskOfAllSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

+ (CGFloat)diskOfFreeSizeMBytes
{
    CGFloat size = 0.0;
    NSError *error;
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
#ifdef DEBUG
        NSLog(@"error: %@", error.localizedDescription);
#endif
    }else{
        NSNumber *number = [dic objectForKey:NSFileSystemFreeSize];
        size = [number floatValue]/1024/1024;
    }
    return size;
}

+(BOOL)CheckMoney:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text hasPrefix:@"."]) {
        textField.text = [NSString stringWithFormat:@"0%@",textField.text];
    }
    
    if ([textField.text hasPrefix:@"0"] &&
        textField.text.length == 1 &&
        [string isEqualToString:@"0"]) {
        return NO;
    }
    
    if ([textField.text hasPrefix:@"0"] &&
        textField.text.length == 1 &&
        ![string isEqualToString:@"0"] &&
        ![[textField.text stringByAppendingString:string] hasPrefix:@"0."]) {
        textField.text = [textField.text substringFromIndex:1];
    }
    
    int textNum = 10;
    NSRange textRange = [textField.text rangeOfString:@"."];
    if (textRange.location<=10) {
        textNum = 13;
    }else if(textField.text.length == 10 && [string isEqualToString:@"."])
    {
        return YES;
    }
    
    if (range.location >= textNum) {
        return NO;
    }else{
        BOOL isHasRadixPoint = YES;
        int RadixPointNum = 2;
        NSString *existText = textField.text;
        if ([existText rangeOfString:@"."].location == NSNotFound) {
            isHasRadixPoint = NO;
        }
        if (string.length > 0) {
            unichar newChar = [string characterAtIndex:0];
            if ((newChar >= '0' && newChar <= '9') || newChar == '.' ) {
                if (newChar == '.') {
                    if (isHasRadixPoint)
                        return NO;
                    else
                        return YES;
                }else {
                    if (isHasRadixPoint) {
                        NSRange ran = [existText rangeOfString:@"."];
                        unsigned long radixPointCount = range.location - ran.location;
                        if (radixPointCount <= RadixPointNum) return YES;
                        else return NO;
                    } else
                        return YES;
                }
            }else {
                return NO;
            }
        }else {
            return YES;
        }
    }
}

+ (void)showToast:(NSError *)error
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KAPPDELEGATE.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = [CommonMethod showErrorMessage:error];
    hud.alpha = 0.6;
    hud.margin = 10.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:3];
}

+ (NSString *)showErrorMessage:(NSError *)error
{
    NSString *errorName =[[error userInfo] objectForKey:@"error_description"];
    NSString *errorCode = [[error userInfo] objectForKey:@"error_code"];
    NSString *errorName_Code = [NSString stringWithFormat:@"%@ [ %@ ]",errorName,errorCode];
    NSString *errorLeaveName_Code = [NSString stringWithFormat:@"登录失效，请重新登录！［%@］",errorCode];
    if ([[[error userInfo] objectForKey:@"error_description"] length]==0 && [[[error userInfo] objectForKey:@"error_code"] length]==0)
    {
        NSString *message = [error localizedDescription];
        if ([message isEqualToString:@"Could not connect to the server."]) {
            message = @"无法连接服务器!";
        }else if([message isEqualToString:@"The request timed out."])
        {
            message = @"连接服务器超时!";
        }else if([message isEqualToString:@"The operation couldn’t be completed."])
        {
            message = errorName;
        }else if ([message isEqualToString:@"The Internet connection appears to be offline."])
        {
            message = @"网络链接失败，请检查网络";
        }else if ([message isEqualToString:@"The network connection was lost."])
        {
            message = @"网络链接失败，请检查网络";
        }
        return message;
    }else{
        if ([errorName contains:@"验证码错误.动态验证码错误"])  {
            return [errorName_Code replaceAll:@".动态验证码错误" with:@""];
        }
        if ([errorName isEqualToString:@"您的账号已在别处登录，请注意账号安全！"] || [errorName isEqualToString:@"登录失效，请重新登录！"] || [errorCode isEqualToString:@"ASR-000003"]|| [errorCode isEqualToString:@"ASR-000004"]|| [errorCode isEqualToString:@"ASR-000005"]|| [errorCode isEqualToString:@"ASR-000006"]|| [errorCode isEqualToString:@"invalid_token"]|| [errorCode isEqualToString:@"invalid_grant"]) {
            
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
            for (id obj in _tmpArray) {
                [cookieJar deleteCookie:obj];
            }
            [KAPPDELEGATE hideProgressView];
            
//            [KAPPDELEGATE setFirstRootVC];

            
            return errorLeaveName_Code;
            
            
        }else{
            return errorName_Code;
            
        }
        
    }
}

+(BOOL)userNameIsRightInputWithString:(NSString*)string{

    if(string.length <=1 && (string.length >=100 && ![string isEqualToString:@""]))
    {
        return NO;
    }
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:MAYUSERDCHARACTER ] invertedSet];
    //invertedSet 方法是去反字符,把所有的除了数字的字符都找出来
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    //componentsSeparatedByCharactersInSet 方法是把输入框输入的字符string 根据cs中字符一个一个去除cs字符并分割成单字符并转化为 NSArray, 然后componentsJoinedByString 是把NSArray 的字符通过 ""无间隔连接成一个NSString字符 赋给filtered.就是只剩数字了.
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        [self showToast1:@"请输入数字字母或者下划线"];
        return NO;
    }
    return basicTest;

    
}




#pragma mark - CFCErrorTable
+ (NSString*)getCFCError:(NSString*)pErrorCode
{
    switch ((NSUInteger)pErrorCode)
    {
            // 1. 通用错误码
        case 0:
            return @"成功";
        case -1:
            return @"通用错误";
        case 0x80070057:
            return @"参数错误";
            // 2. CryptoKernel错误码
        case 0x80071770:
            return @"加密失败";
        case 0x80071771:
            return @"解密失败";
        case 0x80090002:
            return @"错误的哈希";
        case 0x80090006:
            return @"签名错误";
        case 0x80090008:
            return @"错误的算法";
        case 0x80093100:
            return @"ASN1编码错误";
        case 0xA0071004:
            return @"BASE64编码错误";
        case 0xA0071005:
            return @"BASE64解码错误";
            // 3. SIPKit错误码
        case 0xE0010001:
            return @"加密句柄无效";
        case 0xE0010002:
            return @"不支持的算法";
        case 0xE0010003:
            return @"输入数据为空";
        case 0xE0010004:
            return @"服务端随机数为空";
        case 0xE0010005:
            return @"密码格式错误，请输入6-15位字母、数字！";
        case 0xE0010006:
            return @"未知的输出类型";
        case 0xE0010007:
            return @"服务器随机数长度错误";
            // 4. SIPKeyboard错误码
        case 0xB0010001:
            return @"输入内容过长";
        case 0xB0010002:
            return @"释放句柄失败";
        case 0xB0010003:
            return @"创建键盘失败";
        case 0xB0010004:
            return @"创建句柄失败";
        case 0xB0010005:
            return @"清空输入内容失败";
        case 0xB0010006:
            return @"加密状态为FALSE，获取加密内容失败";
            // 5. SIPInputField错误码
        case 0xC0010001:
            return @"输入长度不在有效范围";
        case 0xC0010002:
            return @"位置的键盘类型";
        case 0xC0010003:
            return @"未知的输出数据类型";
        case 0xC0010004:
            return @"未知的公钥Index";
        case 0xC0010005:
            return @"参数无效";
        default:
            return @"";
    }
}




+(void)showToast1:(NSString *)msg
{
    MESSAGE(msg);
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:KAPPDELEGATE.window animated:YES];
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = msg;
//    hud.alpha = 0.6;
//    hud.margin = 10.f;
//    hud.yOffset = 0.f;
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:3];
}

+(NSString*) createUUID {
    CFUUIDRef uuid = CFUUIDCreate(nil);
    CFStringRef cfstring = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    const char *cStr = CFStringGetCStringPtr(cfstring,CFStringGetFastestEncoding(cfstring));
    unsigned char result[16];
    CC_MD5(cStr,(CC_LONG)strlen(cStr), result );
    CFRelease(cfstring);
    CFRelease(uuid);
    
    NSString * _openUDID = [NSString stringWithFormat:
                            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                            result[0], result[1], result[2], result[3],
                            result[4], result[5], result[6], result[7],
                            result[8], result[9], result[10], result[11],
                            result[12], result[13], result[14], result[15]];
    return _openUDID;
}



+ (NSString*)getDateStringFromTimeInterval:(NSString*)timeIntervalString {
    NSString *result = nil;
    if (timeIntervalString) {
        NSString *str =  [timeIntervalString stringByReplacingOccurrencesOfString:@"," withString:@""];
        double time = [str doubleValue]/1000;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter *format= [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM-dd";
        result = [format stringFromDate:date];
    }
    
    return result;
}

/*
 买入-buy，快速卖出- quicksell，普通卖出- normalsell，自动买入创建- autobuycreate，自动买入修改- autobuyupdate，信用卡还款签约-creditcardpaycreate，信用卡还款修改-creditcardpayupdate，信用卡还款解约-creditcardpaydel换卡-changecard用于获取不同的模板号
 
*/
+(NSString*)getTheDealTypeWithRemark:(NSString*)remark{

    if ([remark isEqualToString:@"buy"]) {
        return @"01";
    }
    if([remark isEqualToString:@"quicksell"])
    {
      return @"02";
    }
    if([remark isEqualToString:@"normalsell"])
    {
        return @"04";
    }
    if([remark contains:@"autobuy"])
    {
        return @"03";
    }
    if([remark contains:@"creditcard"])
    {
        return @"05";
    }
    return @"06";
}


+(int)tryUnLockCount
{
    return  (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"tryUnLockCount"];
}

+(void)setTryUnLockCount:(int)count
{
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"tryUnLockCount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)isCachePassWord{
    return YES;
//    return ((NSString*)[CacheMethod userDefaultvalueForKey:GESTUREPASSWORD]).length >3 ;
}

+ (NSString *)formattedDigitalComputingAlgorithm:(NSString *)algorithmMode firstNumber:(NSString *)firstNum secondNumber:(NSString *)secondNum
{
    /*
     1.RoundingMode:
         NSRoundPlain：四舍五入
         NSRoundDown：超过的位数都舍弃
         NSRoundUp：超过的位数向前进1
         NSRoundBankers：
     2.scale：就是保留几位小数
     3.raiseOnExactness：如果设置为YES，当精确度发生错误的时候会抛出异常，否则就直接返回NAN
     4.raiseOnOverflow：如果设置为YES，当发生溢出时会抛出异常，否则就直接返回NAN
     5.raiseOnUnderflow：如果设置为YES，当发生下溢时会抛出异常，否则就直接返回NAN
     6.raiseOnDivideByZero：如果设置为YES，当除以0时会抛出异常，否则就直接返回NAN
     */
    NSDecimalNumberHandler *roundMode = [NSDecimalNumberHandler
                                         decimalNumberHandlerWithRoundingMode:NSRoundDown
                                         scale:2
                                         raiseOnExactness:NO
                                         raiseOnOverflow:NO
                                         raiseOnUnderflow:NO
                                         raiseOnDivideByZero:YES];
    
    NSDecimalNumber *firstDecimalNum = [NSDecimalNumber decimalNumberWithString:firstNum];
    NSDecimalNumber *secondDecimalNum = [NSDecimalNumber decimalNumberWithString:secondNum];
    NSDecimalNumber *operationResult = nil;
    
    if ([algorithmMode isEqualToString:@"Add"]) {
        operationResult = [firstDecimalNum decimalNumberByAdding:secondDecimalNum withBehavior:roundMode];
        
        
    }else if ([algorithmMode isEqualToString:@"Subtract"]){
        operationResult = [firstDecimalNum decimalNumberBySubtracting:secondDecimalNum withBehavior:roundMode];
        
        
    }else if ([algorithmMode isEqualToString:@"Multiply"]){
        operationResult = [firstDecimalNum decimalNumberByMultiplyingBy:secondDecimalNum withBehavior:roundMode];
        
        
    }else if ([algorithmMode isEqualToString:@"Divide"]){
        operationResult = [firstDecimalNum decimalNumberByDividingBy:secondDecimalNum withBehavior:roundMode];
        
        
    }
    
    
    return operationResult.stringValue;
}

+ (NSString*)NSNullOrNilToString:(NSString*)str {
    NSString* result;
    if ([str isKindOfClass:[NSNull class]]) {
        result = @"";
    }
    else {
        result = (str?str:@"");
    }
    
    
    return result;
}

+ (BOOL)isIncludeSpecialCharact:(NSString *)str
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"0123456789~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€!%/,=-+_?':;\\|}{[]\""]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

+ (NSArray *)selectColorWithNumber:(NSInteger)number
{
    NSMutableArray *colorsArray = [NSMutableArray arrayWithArray:@[@"A8D066",@"EEA657",@"A29BC8",@"F2CB59",@"F87346"]];
    NSMutableArray *selectArray = [NSMutableArray array];
//    for (int i=0; i<number; i++) {
//        NSInteger rand = arc4random()%(5-i);
//        [selectArray addObject:colorsArray[rand]];
//        [colorsArray removeObjectAtIndex:rand];
//    }
    
    for (int i=0; i<number; i++) {
        NSInteger rand = arc4random()%5;
        [selectArray addObject:colorsArray[rand]];
    }
    return (NSArray *)selectArray;
}

+ (NSString*)stringValueIncrease:(NSString*)string {
    int value = [string intValue] + 1;
    return [NSString stringWithFormat:@"%d",value];
}

+ (NSString*)stringValueDecrease:(NSString*)string {
    int value = [string intValue] - 1;
    if (value < 0) value = 0;
    return [NSString stringWithFormat:@"%d",value];
}

+ (NSString *)switchWithString:(NSString *)string
{
    if (string.length>=19) {
        string = [string substringToIndex:19];
        
        NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
        dateForm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *phoneDate = [dateForm dateFromString:string];
        
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:phoneDate];
        if (timeInterval<0) {
            return [string substringToIndex:16];
        }else if (timeInterval<60) {
            return [NSString stringWithFormat:@"%.0f秒前",timeInterval];
        }else if (timeInterval<3600){
            return [NSString stringWithFormat:@"%.0f分钟前",timeInterval/60];
        }else if (timeInterval<3600*24){
            return [NSString stringWithFormat:@"%.0f小时前",timeInterval/3600];
        }else{
            return [string substringToIndex:16];
        }
    }
    return string;
}

@end






