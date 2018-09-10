//
//  AISendPackConfigEntity.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//  页面的配置数据

#import <Foundation/Foundation.h>


@interface AISendPackConfigEntity : NSObject

/**
 群人数
 */
@property (strong, nonatomic)NSNumber *groupSize;

/** 祝福语*/
@property(nonatomic,copy)NSString *greeting;
/** 提示语*/
@property(nonatomic,copy)NSString *tips;
@property (nonatomic,assign)BOOL isEnableButton;

/**当日红包已经发送次数*/
@property (nonatomic, strong) NSNumber * redPacketDailyCount;
/**当日红包最大次数*/
@property (nonatomic, strong) NSNumber * redPacketDailyCountMax;
/**当日红包已经发送金额*/
@property (nonatomic, strong) NSNumber * redPacketDailyMoney;
/**当日红包最大发送金额*/
@property (nonatomic, strong) NSNumber * redPacketDailyMoneyMax;
/**单个红包最大发送金额*/
@property (nonatomic, strong) NSNumber * redPacketSingleMoneyMax;
/**单个红包最小发送金额*/
@property (nonatomic, strong) NSNumber * redPacketSingleMoneyMin;

//MARK:JmoVxia---发群红包
/**群红包最大发送金额*/
@property (nonatomic, strong) NSNumber * redPacketGroupMoneyMax;
/**群红包最大发送个数*/
@property (nonatomic, strong) NSNumber * redPacketGroupSplitMax;
/**余额*/
@property (nonatomic, strong) NSNumber * money;
/**是否设置支付密码*/
@property (nonatomic, strong) NSNumber * payPassword;
@end
