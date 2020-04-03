//
//  GOPCircleProgressView.m
//  BleLocker
//
//  Created by Alex Chan on 2019/3/15.
//  Copyright © 2019 北京果加智能科技有限公司. All rights reserved.
//

#import "GOPCircleProgressView.h"


@implementation GOPCircleProgressView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    UIBezierPath *path;
    CAShapeLayer *progressLayer;
    CAShapeLayer *shapeLayer;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {

    
    self.progressColor = UIColor.redColor;
    self.progressBgColor = UIColor.grayColor;
    self.progressWidth = 30;
    
    path = [UIBezierPath bezierPath];
    [self simpleShape];
}

-(void)createCirclePath {
    
    
    NSUInteger x = self.frame.size.width/2;
    NSUInteger y = self.frame.size.height/2;
    CGPoint center = CGPointMake(x, y);
    path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:x startAngle:-M_PI endAngle:M_PI*2-M_PI clockwise:YES];
    [path closePath];
}

-(void)simpleShape {
    [self createCirclePath];
    
    shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = self.progressWidth;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = self.progressBgColor.CGColor;
    
    
    progressLayer = [[CAShapeLayer alloc] init];
    progressLayer.path = path.CGPath;
    progressLayer.lineWidth = self.progressWidth;
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.fillColor = nil;
    progressLayer.strokeColor = self.progressColor.CGColor;
    progressLayer.strokeEnd = 0;
    
    [self.layer addSublayer: shapeLayer];
    [self.layer addSublayer: progressLayer];
}

- (void)setProgress:(NSUInteger )progress {
    if(progress > 100 ) {
        progress = 100;
    }
    if(progress < 0 ){
        progress = 0;
    }
    progressLayer.strokeEnd = (CGFloat)(progress/100.0);
}

@end
