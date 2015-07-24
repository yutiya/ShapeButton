//
//  ShapeButton.m
//  ShapeButton
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 Pandora. All rights reserved.
//

#import "ShapeButton.h"
#import <QuartzCore/QuartzCore.h>

#define CircleRadius 24
#define LineSpace 4
#define π M_PI

@interface ShapeButton ()

@property (strong, nonatomic) CAShapeLayer *circleLayer;
@property (strong, nonatomic) CAShapeLayer *lineLayer;
@property (assign, nonatomic) CGFloat lineWidth;

@end

@implementation ShapeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.circleLayer = [[CAShapeLayer alloc] init];
        self.circleLayer.path = [self circlePath];
        self.circleLayer.fillColor = nil;
        self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.circleLayer.strokeStart = 0.5;
        self.circleLayer.strokeEnd = 0.5;
        self.circleLayer.lineWidth = self.lineWidth;
        self.circleLayer.position = CGPointMake(0,0);
        [self.layer addSublayer:self.circleLayer];
        
        self.lineLayer = [[CAShapeLayer alloc] init];
        self.lineLayer.path = [self linePath];
        self.lineLayer.fillColor = nil;
        self.lineLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.lineLayer.lineCap = kCALineCapRound;
        self.lineLayer.lineWidth = 4;
        self.lineLayer.position = CGPointMake(0,0);
        [self.layer addSublayer:self.lineLayer];
    }
    return self;
}

- (void)setShowCircle:(BOOL)showCircle
{
    _showCircle = showCircle;
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    if (showCircle) {
        strokeStart.toValue = @0;
        strokeStart.duration = 1.2;
        strokeStart.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.25 :-0.4 :0.5 :1];
        
        strokeEnd.toValue = @1;
        strokeEnd.duration = 1.3;
        strokeEnd.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.25 :-0.4 :0.5 :1];
    }else{
        strokeStart.toValue = @0.5;
        strokeStart.duration = 1.2;
        strokeStart.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.25 :0 :0.5 :1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = @0.5;
        strokeEnd.duration = 1.3;
        strokeEnd.timingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints:0.25 :0.3 :0.5 :0.9];
    }
    [self.circleLayer addAnimation:strokeStart forKey:strokeStart.keyPath];
    [self.circleLayer addAnimation:strokeEnd forKey:strokeEnd.keyPath];
    [self.circleLayer setValue:strokeStart.toValue forKeyPath:strokeStart.keyPath];
    [self.circleLayer setValue:strokeEnd.toValue forKeyPath:strokeEnd.keyPath];
}

- (CGPathRef)linePath
{
    CGFloat boundsWidthC2 = self.bounds.size.width/2.0;
    CGFloat boundsHeightC2 = self.bounds.size.height/2.0;
    self.lineWidth = MIN(boundsWidthC2, boundsHeightC2)/3 * 2 - LineSpace;
    CGMutablePathRef mpath = CGPathCreateMutable();
    CGPathMoveToPoint(mpath, nil, boundsWidthC2, LineSpace + 3.7);
    CGPathAddLineToPoint(mpath, nil, boundsWidthC2, LineSpace + self.lineWidth);
    CGPathRef path = CGPathCreateCopy(mpath);
    return path;
}

- (CGPathRef)circlePath
{
    CGFloat boundsWidthC2 = self.bounds.size.width/2.0;
    CGFloat boundsHeightC2 = self.bounds.size.height/2.0;
    self.lineWidth = MIN(boundsWidthC2, boundsHeightC2)/3 * 2 - LineSpace;
    CGPoint center = CGPointMake(boundsWidthC2, boundsHeightC2);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:self.lineWidth
                                                          startAngle:π * 5/4
                                                            endAngle:π * 7/4
                                                           clockwise:true];
    return bezierPath.CGPath;
}


@end
