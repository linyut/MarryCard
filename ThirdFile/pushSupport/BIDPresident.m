//
//  BIDPresident.m
//  Nav
//

#import "BIDPresident.h"

@implementation BIDPresident



#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.messageUser forKey:@"messageUser"];
    [coder encodeObject:self.messageConstent forKey:@"messageConstent"];
    [coder encodeObject:self.messageTime forKey:@"messageTime"];
    [coder encodeObject:self.messageReaded forKey:@"messageReaded"];
    [coder encodeObject:self.messageDetailTime forKey:@"messageDetailTime"];
    [coder encodeObject:self.messageId forKey:@"messageId"];
    
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.messageUser     = [coder decodeObjectForKey:@"messageUser"];
        self.messageConstent = [coder decodeObjectForKey:@"messageConstent"];
        self.messageTime     = [coder decodeObjectForKey:@"messageTime"];
        self.messageReaded   = [coder decodeObjectForKey:@"messageReaded"];
        self.messageDetailTime   = [coder decodeObjectForKey:@"messageDetailTime"];
        self.messageId   = [coder decodeObjectForKey:@"messageId"];
    }
    return self;
}

- (MessageType) sureMessageType
{
    if( [self.messageConstent contains:@"党费通知"] )
    {
        return DangFei;
    }
    else if( [self.messageConstent contains:@"复兴头条"] )
    {
        return Huolizhonghang;
    }
    else if( [self.messageConstent contains:@"支部邀请"] || [self.messageConstent contains:@"支部加入申请"] )
    {
        return GongGao;
    }
    else
        return Other;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone;
{
    BIDPresident *copy = [[BIDPresident alloc] init];
    
    copy.messageUser = self.messageUser;
    copy.messageConstent = self.messageConstent;
    copy.messageTime = self.messageTime;
    copy.messageReaded = self.messageReaded;
    copy.messageDetailTime = self.messageDetailTime;
    copy.messageId = self.messageId;
    return copy;
}

@end
