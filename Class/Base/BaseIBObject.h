//
//  BaseIBObject.h
//  InternetBanking
//
//  Created by Simon on 16/6/13.
//  Copyright © 2016年 柳宣泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseIBObject : NSObject<NSCoding>
/**
 初始化类
 @param  (NSDictionary*)data
 @return id 类型本身实列
 */
- (id)initWithDataDic:(NSDictionary*)data;
-(id)initWithDic:(NSDictionary*)data;
/**
 属性映射成字典
 @param  无
 @return NSDictionary
 */
- (NSDictionary*)attributeMapDictionary;

/**
 设置属性
 @param  dataDic
 @return 无
 */
- (void)setAttributes:(NSDictionary*)dataDic;

/**
 获取自定义描述
 @param  无
 @return NSString
 */
- (NSString *)customDescription;

/**
 获取描述
 @param  无
 @return NSString
 */
- (NSString *)description;

/**
 获取描述
 @param  无
 @return NSString
 */
- (void )ConvertToDecimal;

/**
 把自身属性数据封装成二进制放回
 @param  无
 @return NSData
 */
- (NSData*)getArchivedData;

/**
 保存自身到本地
 @param  无
 @return NO
 */
-(void)SaveToLocal;

/**
 获取自身本地缓存数据
 @param  无
 @return BOCOPPayBaseModelObject
 */
+(BaseIBObject *)GetLocalSelf;



@end
