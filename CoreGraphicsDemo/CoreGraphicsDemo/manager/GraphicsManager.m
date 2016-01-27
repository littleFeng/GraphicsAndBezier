//
//  GraphicsManager.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 15/11/4.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "GraphicsManager.h"


@implementation GraphicsManager

+ (void)drawLineWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width lineAlpha:(CGFloat)alpha dashLength:(CGFloat)length
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShouldAntialias(context, YES); //YES:抗锯齿
    CGContextRetain(context);
    CGContextSetAlpha(context , alpha);
    if(length!=0)
    {
        CGFloat lengths[] = {length,length};
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(Linecolorspace1);
}

+(void)drawCircle:(CGPoint)point withColor:(UIColor*)color withRadli:(CGFloat)rad
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillEllipseInRect(context, CGRectMake(point.x-rad, point.y-rad, 2*rad, 2*rad));
    CGContextRestoreGState(context);
}

+(void)drawDonut:(CGPoint)point withInColor:(UIColor*)inColor withOutColor:(UIColor *)outColor  withRadMin:(CGFloat)radMin withRadMax:(CGFloat)radMax
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [outColor CGColor]);
    CGContextFillEllipseInRect(context, CGRectMake(point.x-radMax, point.y-radMax, 2*radMax, 2*radMax));
    CGContextSetFillColorWithColor(context, inColor.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(point.x-radMin, point.y-radMin, 2*radMin, 2*radMin));
    CGContextRestoreGState(context);
}

+(void)DrawpathWithPointArr:(NSArray*)pPointArr withColor:(UIColor*)color withLineColor:(UIColor *)lineColor withFillAlpha:(CGFloat)alpha lineAlpha:(CGFloat)lineAlpha borderWidth:(CGFloat)borderWidth
{
    if (!pPointArr || pPointArr.count<=2)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [lineColor setStroke];
    [color setFill];
    CGContextSetLineWidth(context,borderWidth);
    CGContextBeginPath(context);
    for (int i = 0; i<pPointArr.count; ++i)
    {
        CGPoint point;
        [[pPointArr objectAtIndex:i]getValue:&point];
        if (i == 0)
            CGContextMoveToPoint(context, point.x, point.y);
        else
            CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
    CGContextRelease(context);
}
+(void)drawBreakenLineWithPointArr:(NSArray *)pointArr lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width lineAlpha:(CGFloat)lineAlpha
{
    if(!pointArr || pointArr.count == 0)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextSetAlpha(context, lineAlpha);
    CGContextBeginPath(context);
    for(int i =0;i<pointArr.count;i++)
    {
        CGPoint point = CGPointZero;
        [[pointArr objectAtIndex:i] getValue:&point];
        if(i == 0)
            CGContextMoveToPoint(context, point.x, point.y);
        else
            CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

+(void)drawFillPathWithPointArr:(NSArray *)pointArr withColor:(UIColor *)color fillAlpha:(CGFloat)alpha
{
    if(!pointArr || pointArr.count == 0)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextSetAlpha(context, alpha);
    CGContextBeginPath(context);
    for(int i =0;i<pointArr.count;i++)
    {
        CGPoint point = CGPointZero;
        [[pointArr objectAtIndex:i] getValue:&point];
        if(i == 0)
            CGContextMoveToPoint(context, point.x, point.y);
        else
            CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextFillPath(context);
    CGContextRestoreGState(context);
}

+(void)drawArcWithCenter:(CGPoint)center radius:(CGFloat)rad startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)width lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor clockwise:(BOOL)wise
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextAddArc(context, center.x, center.y, rad, startAngle, endAngle, wise);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}
@end
