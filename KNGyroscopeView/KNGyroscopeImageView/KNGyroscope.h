//
//  KNGyroscope.h
//  KNGyroscopeView
//
//  Created by 刘凡 on 2017/12/8.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface KNGyroscope : NSObject


@property(nonatomic, strong)CMMotionManager *manger;

///时间间隔
@property(nonatomic, assign)float timeInterval;


/**
 单例方法创建

 @return 单例
 */
+(KNGyroscope *)sharedGyroscope;



/**
 开始重力加速度

 @param complete 重力加速block, 返回XYZ
 */
-(void)startAccelerationOfGravityBlock:(void(^)(float x,float y,float z))complete;


/**
 开始重力感应

 @param complete 重力感应block,返回XYZ
 */
-(void)stratAccelerometerBlock:(void(^)(float x,float y,float z))complete;


/**
 开始陀螺仪

 @param complete 陀螺仪block,返回XYZ
 */
-(void)stratGyroscopeBlock:(void(^)(float x,float y,float z))complete;

///停止
-(void)stop;

@end
