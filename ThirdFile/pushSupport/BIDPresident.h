//
//  BIDPresident.h
//  Nav
//

#import <Foundation/Foundation.h>

typedef enum {
    DangFei = 1,
    Huolizhonghang,
    GongGao,
    Other,
} MessageType;


@interface BIDPresident : NSObject <NSCoding, NSCopying>

@property (strong, nonatomic) NSString * messageUser;     //针对哪个用户的消息
@property (strong, nonatomic) NSString * messageConstent; //推送消息的内容
@property (strong, nonatomic) NSString * messageTime;     //推送消息的时间
@property (strong, nonatomic) NSString * messageReaded;   //推送消息是否之前被推送过
@property (strong, nonatomic) NSString * messageDetailTime; //推送消息的具体时间
@property (strong, nonatomic) NSString * messageId;       //推送消息的唯一标示

- (MessageType) sureMessageType;

@end
