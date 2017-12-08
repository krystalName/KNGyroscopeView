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


@end
