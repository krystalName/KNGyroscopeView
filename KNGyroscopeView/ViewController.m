//
//  ViewController.m
//  KNGyroscopeView
//
//  Created by 刘凡 on 2017/12/7.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import "ViewController.h"
#import "KNGyroscopeImageView.h"


@interface ViewController ()

//陀螺仪View
@property(nonatomic, strong)KNGyroscopeImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageView = [[KNGyroscopeImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.image = [UIImage imageNamed:@"1"];
    
    //开始动画
    [_imageView startAnimate];
    
    [self.view addSubview:_imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
