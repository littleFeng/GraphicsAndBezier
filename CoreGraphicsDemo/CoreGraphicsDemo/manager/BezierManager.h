//
//  CGPathManager.h
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/25.
//  Copyright © 2016年 feng. All rights reserved.
//
//利用CASharpLayer 进行绘制

#import <UIKit/UIKit.h>

@interface BezierManager : NSObject

/**
 *
 * @brief  画直线
 *
 * @param startPoint 起始坐标
 * @param endPoint   终点坐标
 * @param lineColor  线色
 * @param width      线宽
 * @param alpha      透明度
 */
+ (void)drawLineWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width  duration:(CGFloat)duration  inView:(UIView * )view;
/**
 *
 * @brief  实心圆
 *
 * @param point 圆心
 * @param color 填充色
 * @param radli 半径
 */
+(void)drawCircle:(CGPoint)point withColor:(UIColor*)color withRadli:(CGFloat)rad duration:(CGFloat)duration inView:(UIView * )view;

/**
 *
 * @brief  绘制折线 曲线
 *
 * @param pointArr  关键点坐标数组
 * @param width    线宽
 * @param lineColor  线的颜色
 */
+(void)drawBreakenLineWithPointArr:(NSArray * )pointArr lineColor:(UIColor * )lineColor lineWidth:(CGFloat)width  duration:(CGFloat)duration inView:(UIView * )view;


/**
 *
 * @brief  绘制扇形
 *
 * @param center    圆心
 * @param rad       圆半径
 * @param startAngle 起始弧度
 * @param endAngle   结束弧度
 * @param width      线宽
 * @param lineColor  线的颜色
 * @param fillColor  填充色
 * @param clockwise   是否顺时针
 */

+(void)drawArcWithCenter:(CGPoint)center radius:(CGFloat)rad  arcWidth:(CGFloat)width startAngle:(CGFloat)startAngle  endAngle:(CGFloat)endAngle arcColor:(UIColor * )lineColor fillColor:(UIColor * )fillColor clockwise:(BOOL)wise duration:(CGFloat)duration inView:(UIView * )view ;

/**
 *
 * @brief  绘制一个 不闭合的面
 *
 * @param pointArr  关键点坐标数组
 * @param color  填充颜色
 * @param alpha      透明度
 */
+(void)drawFillPathWithPointArr:(NSArray * )pointArr withColor:(UIColor * )color duration:(CGFloat)duration inView:(UIView * )view;


@end
