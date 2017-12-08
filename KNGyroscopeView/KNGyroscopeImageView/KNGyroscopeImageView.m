//
//  KNGyroscopeImageView.m
//  KNGyroscopeView
//
//  Created by 刘凡 on 2017/12/8.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "KNGyroscopeImageView.h"
#import "KNGyroscope.h"

#define SPEED 50

@implementation KNGyroscopeImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    _myImageView = [[UIImageView alloc]init];
    [self addSubview:_myImageView];
}

//设置图片之后
-(void)setImage:(UIImage *)image
{
    _image = image;
    [_myImageView setImage:image];
    [_myImageView sizeToFit];
    //设置图片View的大小
    _myImageView.frame = CGRectMake(0, 0, self.frame.size.height * (_myImageView.frame.size.width / _myImageView.frame.size.height), self.frame.size.height);
    
    _myImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}


-(void)startAnimate
{
    float scrollSpeed = (_myImageView.frame.size.width - self.frame.size.width)/2/SPEED;
    [KNGyroscope sharedGyroscope].timeInterval = 1;
    
    //这里调用陀螺仪开始的方法
    [[KNGyroscope sharedGyroscope]startGyroscopeBlock:^(float x, float y, float z) {
        
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
            
            if (_myImageView.frame.origin.x <= 0 && _myImageView.frame.origin.x >= self.frame.size.width - _myImageView.frame.size.width)
            {
                float invertedYRotationRate = y * -1.0;
                
                float interpretedXOffset = _myImageView.frame.origin.x + invertedYRotationRate * (_myImageView.frame.size.width/[UIScreen mainScreen].bounds.size.width) * scrollSpeed + _myImageView.frame.size.width/2;
                
                _myImageView.center = CGPointMake(interpretedXOffset, _myImageView.center.y);
            }
            
            if (_myImageView.frame.origin.x >0)
            {
                _myImageView.frame = CGRectMake(0, _myImageView.frame.origin.y, _myImageView.frame.size.width, _myImageView.frame.size.height);
            }
            if (_myImageView.frame.origin.x < self.frame.size.width - _myImageView.frame.size.width)
            {
                _myImageView.frame = CGRectMake(self.frame.size.width - _myImageView.frame.size.width, _myImageView.frame.origin.y, _myImageView.frame.size.width, _myImageView.frame.size.height);
            }
        } completion:nil];
        
        
    }];
}

-(void)stopAnimate
{
    [[KNGyroscope sharedGyroscope] stop];
}



@end
