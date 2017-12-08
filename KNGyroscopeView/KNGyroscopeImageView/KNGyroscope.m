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
    void(^_startAccelerometerBlock)(float x,float y,float z);
    ///陀螺仪block
    void(^_startGyroscopeBlock)(float x,float y,float z);
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




//开始重力感应
-(void)startAccelerometerBlock:(void (^)(float, float, float))complete
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
                NSLog(@"%@",error.localizedDescription);
            }
            else
            {
                _startAccelerometerBlock = complete;
                
                [self performSelectorOnMainThread:@selector(gyroUpdate:) withObject:gyroData waitUntilDone:NO];
            }
        }];
    }else{
        NSLog(@"设备没有重力感应");
    }
}


-(void)gyroUpdate:(CMGyroData *)gyroData
{
    //分量
    _startAccelerometerBlock(gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
}

//开始重力加速
-(void)startAccelerationOfGravityBlock:(void (^)(float, float, float))complete
{
    //如果是重力加速
    if(_manger.accelerometerAvailable){
        //设置时间
        _manger.accelerometerUpdateInterval = _timeInterval;
        
        //开始加速
        [_manger startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
           //如果报错
            if (error) {
                [_manger stopAccelerometerUpdates];
                
                NSLog(@"%@",error.localizedDescription);
            }else{
            
                _startAccelerationOfGravityBlock = complete;
                //回到主线程中
                [self performSelectorOnMainThread:@selector(accelerometUpdate:) withObject:accelerometerData waitUntilDone:NO];
            }
        }];
    }else{
        NSLog(@"设备没有加速器");
    }
}

-(void)accelerometUpdate:(CMAccelerometerData *)accelerometerData{
    
    _startAccelerationOfGravityBlock(accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
}


//开始陀螺仪
-(void)startGyroscopeBlock:(void (^)(float, float, float))complete{
    
    //判断有无重力陀螺仪
    if (_manger.deviceMotionAvailable) {
        _manger.deviceMotionUpdateInterval = _timeInterval;
        
        [_manger startDeviceMotionUpdatesToQueue:_queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
           
            if (error) {
                //停止陀螺仪
                [_manger stopDeviceMotionUpdates];
                NSLog(@"%@",error.localizedDescription);
            }else{
                _startGyroscopeBlock = complete;
                //回到主线程
                [self performSelectorOnMainThread:@selector(gyroscopeUpdate:) withObject:motion waitUntilDone:NO];
            }
        }];
        
    }else
    {
        NSLog(@"设备没有陀螺仪");
    }
}

-(void)gyroscopeUpdate:(CMDeviceMotion *)motion
{
    _startGyroscopeBlock(motion.rotationRate.x,motion.rotationRate.y,motion.rotationRate.z);
}


//停止
-(void)stop
{
    [_manger stopDeviceMotionUpdates];
    [_manger stopGyroUpdates];
    [_manger stopAccelerometerUpdates];
}



@end
