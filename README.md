# KNGyroscopeView

## 先上传一张效果图 ， 不是手在滑动。。 而是手机左右倾斜～

![](https://github.com/krystalName/KNGyroscopeView/blob/master/GyroscopeView.gif)

+ 其实做法很简单。 导入一个内置库<CoreMotio/CoreMotion.h>。 调用陀螺仪启动方法
+ 然后根据手机倾斜时。 返回的X.Y.Z 参数。 去修改图片的frame


### 参考方法如下~   这是根据返回的x.y.z  对图片的frame做适当的修改

```objc


   //这里调用陀螺仪开始的方法
    [[KNGyroscope sharedGyroscope] startGyroscopeBlock:^(float x, float y, float z) {
        
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
            
            if (_myImageView.frame.origin.x <= 0 && _myImageView.frame.origin.x >= self.frame.size.width - _myImageView.frame.size.width)
            {
                float invertedYRotationRate = y * -1.0;
                
                float interpretedXOffset = _myImageView.frame.origin.x + invertedYRotationRate * (_myImageView.frame.size.width/[UIScreen mainScreen].bounds.size.width) * scrollSpeed + _myImageView.frame.size.width/2;
                
                _myImageView.center = CGPointMake(interpretedXOffset, _myImageView.center.y);
            }
            
            if (_myImageView.frame.origin.x > 0)
            {
                _myImageView.frame = CGRectMake(0, _myImageView.frame.origin.y,_myImageView.frame.size.width, _myImageView.frame.size.height);
            }
            if (_myImageView.frame.origin.x < self.frame.size.width - _myImageView.frame.size.width)
            {
                _myImageView.frame = CGRectMake(self.frame.size.width - _myImageView.frame.size.width, _myImageView.frame.origin.y, _myImageView.frame.size.width, _myImageView.frame.size.height);
            }
        } completion:nil];

```
