//
//  AISendPackNetworkManager.h
//  Tomato
//
//  Created by aizexin on 2018/9/8.
//

#import <Foundation/Foundation.h>

@interface AISendPackNetworkManager : NSObject

+ (instancetype)shareManager;
@property (nonatomic, copy) void (^sendRedPacket) (NSDictionary *RedPacketInfo, void (^complete) (NSString *error, int64_t messageId));
@property (nonatomic, copy) void (^sendRedPacketFinished) ();
@property (nonatomic, copy) void (^sendRedPacketError) (int64_t messageId);
@end
