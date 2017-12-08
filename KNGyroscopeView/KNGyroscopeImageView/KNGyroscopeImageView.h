//
//  KNGyroscopeImageView.h
//  KNGyroscopeView
//
//  Created by 刘凡 on 2017/12/8.
//  Copyright © 2017年 KrystalName. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNGyroscopeImageView : UIView

///显示图片
@property(nonatomic, strong)UIImage *image;
@property(nonatomic, strong, readonly) UIImageView *myImageView;


///开始重力感应
-(void)startAnimate;

///停止重力感应
-(void)stopAnimate;

@end
