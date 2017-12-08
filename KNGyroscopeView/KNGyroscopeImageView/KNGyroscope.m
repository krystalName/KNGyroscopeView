//
//  KNGyroscope.m
//  KNGyroscopeView
//
//  Created by 刘凡 on 2017/12/8.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNGyroscope.h"

@implementation KNGyroscope
{
    NSOperationQueue *_queue;
    ///重力加速block
    void(^_startAccelerationOfGravityBlock)(float x,float y,float z);
    ///重力感应block
    void(^_stratAccelerometerBlock)(float x,float y,float z);
    ///陀螺仪block
    void(^_stratGyroscopeBlock)(float x,float y,float z);
}

#pragma mark - 单例实现
+(KNGyroscope *)sharedGyroscope
{
    static KNGyroscope *gyroscope = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gyroscope = [[self alloc]init];
    });
    return gyroscope;
}



-(void)stratAccelerometerBlock:(void (^)(float, float, float))complete
{
    
    //如果有重力感应
    if (_manger.gyroAvailable) {
        
        //设置时间
        _manger.gyroUpdateInterval = _timeInterval;
        
        //block
        [_manger startGyroUpdatesToQueue:_queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            
            if (error) {
                //报错就停止重力感应
                [_manger  stopGyroUpdates];
                NSLog(@"%@",[NSString stringWithFormat:@"gryerror: %@",error]);
            }
            else
            {
                _stratAccelerometerBlock = complete;
                
                [self performSelectorOnMainThread:@selector(gyroUpdate:) withObject:gyroData waitUntilDone:NO];
            }
        }];
    }else{
        NSLog(@"设备没有重力感应");
    }
}


-(void)gyroUpdate:(CMGyroData *)gyroData;
{
    //分量
    _stratAccelerometerBlock(gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
}




-(void)startAccelerationOfGravityBlock:(void (^)(float, float, float))complete
{
    if(_manger.accelerometerAvailable){
        
    }
}



-(instancetype)init
{
    self = [super init];
    if (self) {
        //初始化
        [self configGyroscope];
    }
    return self;
}

-(void)configGyroscope
{
    //初始化
    _manger = [[CMMotionManager alloc]init];
    _queue = [[NSOperationQueue alloc]init];
}




@end
