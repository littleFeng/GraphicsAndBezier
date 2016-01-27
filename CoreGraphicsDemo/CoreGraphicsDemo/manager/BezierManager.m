//
//  CGPathManager.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BezierManager.h"

@implementation BezierManager

+(void)drawLineWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width  duration:(CGFloat)duration inView:(UIView *)view
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.frame = view.frame;
    pathLayer.path = path;
    pathLayer.lineWidth= width;
    pathLayer.strokeColor = lineColor.CGColor;
    [view.layer addSublayer:pathLayer];
    
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue   = [NSNumber numberWithFloat:1.f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}
+(void)drawCircle:(CGPoint)point withColor:(UIColor *)color withRadli:(CGFloat)rad duration:(CGFloat)duration inView:(UIView *)view
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(point.x - rad, point.y - rad,rad,rad));
    
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.frame = view.frame;
    pathLayer.path = path;
    pathLayer.lineWidth = rad;
    pathLayer.strokeColor = color.CGColor;
    pathLayer.fillColor = [UIColor whiteColor].CGColor;
    [view.layer addSublayer:pathLayer];
    
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue   = [NSNumber numberWithFloat:1.f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

+(void)drawBreakenLineWithPointArr:(NSArray *)pointArr lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width duration:(CGFloat)duration inView:(UIView *)view
{
    
    if(!pointArr || pointArr.count == 0)
        return;
    CGMutablePathRef path = CGPathCreateMutable();
    for(int i =0;i<pointArr.count;i++)
    {
        CGPoint point = CGPointZero;
        [[pointArr objectAtIndex:i] getValue:&point];
        if(i == 0)
            CGPathMoveToPoint(path, NULL, point.x, point.y);
        else
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.frame = view.frame;
    pathLayer.path = path;
    pathLayer.strokeColor = lineColor.CGColor;
    pathLayer.lineJoin = kCALineJoinBevel;
    pathLayer.fillColor =nil;
    [view.layer addSublayer:pathLayer];
    
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue   = [NSNumber numberWithFloat:1.f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
}
+(void)drawFillPathWithPointArr:(NSArray *)pointArr withColor:(UIColor *)color duration:(CGFloat)duration inView:(UIView *)view
{
    if(!pointArr || pointArr.count == 0)
        return;
    CGMutablePathRef path = CGPathCreateMutable();
    for(int i =0;i<pointArr.count;i++)
    {
        CGPoint point = CGPointZero;
        [[pointArr objectAtIndex:i] getValue:&point];
        if(i == 0)
            CGPathMoveToPoint(path, NULL, point.x, point.y);
        else
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    
    CGPoint startP = CGPointZero;
    [[pointArr objectAtIndex:0] getValue:&startP];
    CGPoint endP = CGPointZero;
    [[pointArr objectAtIndex:pointArr.count -1] getValue:&endP];
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, startP.x, startP.y);
    CGPathAddLineToPoint(path2, NULL, endP.x, startP.y);
    CGPathCloseSubpath(path2);
//    
    
    CAShapeLayer * fillLayer = [CAShapeLayer layer];
    fillLayer.frame = view.frame;
    fillLayer.lineWidth= 100.f;
    fillLayer.strokeColor = color.CGColor;
    fillLayer.lineJoin = kCALineJoinBevel;
    fillLayer.fillColor =[UIColor clearColor].CGColor ;
    [view.layer addSublayer:fillLayer];
    
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.frame = view.frame;
    pathLayer.path = path;
    pathLayer.lineWidth = 1.0f;
    pathLayer.strokeColor = color.CGColor;
    pathLayer.lineJoin = kCALineJoinBevel;
    pathLayer.fillColor =[UIColor clearColor].CGColor;
    [view.layer addSublayer:pathLayer];
 
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion  = NO;
    pathAnimation.fromValue = @(0.f);
    pathAnimation.toValue   = @(1.0f);
    pathAnimation.beginTime = 0.f;
    [fillLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];


}

+(void)drawArcWithCenter:(CGPoint)center radius:(CGFloat)rad arcWidth:(CGFloat)width startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle arcColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor clockwise:(BOOL)wise duration:(CGFloat)duration inView:(UIView *)view
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:rad *0.5f startAngle:startAngle endAngle:endAngle clockwise:wise];
    
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.frame = view.frame;
    pathLayer.path = path.CGPath;
    pathLayer.lineWidth = rad;
    pathLayer.strokeColor = lineColor.CGColor;
    pathLayer.fillColor = [UIColor whiteColor].CGColor;
    [view.layer addSublayer:pathLayer];
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:center radius:(rad - width) *0.5f startAngle:startAngle endAngle:endAngle clockwise:wise];
    CAShapeLayer * fillLayer = [CAShapeLayer layer];
    fillLayer.frame = view.frame;
    fillLayer.path = path2.CGPath;
    fillLayer.lineWidth = rad -width;
    fillLayer.strokeColor = fillColor.CGColor;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    [view.layer addSublayer:fillLayer];
    
    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue   = [NSNumber numberWithFloat:1.f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    [fillLayer  addAnimation:pathAnimation forKey:@"strokeEnd"];

}
@end
