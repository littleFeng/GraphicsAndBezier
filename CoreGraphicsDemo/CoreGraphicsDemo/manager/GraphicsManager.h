//
//  GraphicsManager.h
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 15/11/4.
//  Copyright © 2015年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

//cpu 损耗  重复绘制时未见内存增长 异常 

@interface GraphicsManager : NSObject

/**
 *
 * @brief  画直线 虚线
 *
 * @param startPoint 起始坐标
 * @param endPoint   终点坐标
 * @param lineColor  线色
 * @param width      线宽
 * @param alpha      透明度
 * @param length     虚线的间隔  默认等间隔 ,  0为实线。
 */
+ (void)drawLineWithstartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width lineAlpha:(CGFloat)alpha dashLength:(CGFloat)length;

/**
 *
 * @brief  实心圆
 *
 * @param point 圆心
 * @param color 填充色
 * @param radli 半径
 */
+(void)drawCircle:(CGPoint)point withColor:(UIColor*)color withRadli:(CGFloat)rad;

/**
 *
 * @brief  圆环
 *
 * @param point    圆心
 * @param inColor  环内的颜色
 * @param outColor 环的颜色
 * @param radMin   小半径
 * @param radMax   大半径
 */
+(void)drawDonut:(CGPoint)point withInColor:(UIColor*)inColor withOutColor:(UIColor *)outColor  withRadMin:(CGFloat)radMin withRadMax:(CGFloat)radMax;

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

+(void)drawArcWithCenter:(CGPoint)center radius:(CGFloat)rad startAngle:(CGFloat)startAngle  endAngle:(CGFloat)endAngle
               lineWidth:(CGFloat)width lineColor:(UIColor * )lineColor fillColor:(UIColor * )fillColor clockwise:(BOOL)wise;

/**
 *
 * @brief  绘制一个闭合的面 可设置闭合边框 各种图形 提供坐标
 *
 * @param pPointArr  关键点坐标数组
 * @param fillColor  填充颜色
 * @param alpha      透明度
 * @param lineColor  线的颜色
 */
+(void)DrawpathWithPointArr:(NSArray*)pPointArr withColor:(UIColor*)fillColor  withLineColor:(UIColor * )lineColor   withFillAlpha:(CGFloat)alpha lineAlpha:(CGFloat)lineAlpha borderWidth:(CGFloat) borderWidth;
/**
 *
 * @brief  绘制一个 不闭合的面
 *
 * @param pointArr  关键点坐标数组
 * @param color  填充颜色
 * @param alpha      透明度
 */
+(void)drawFillPathWithPointArr:(NSArray * )pointArr withColor:(UIColor * )color fillAlpha:(CGFloat)alph;
/**
 *
 * @brief  绘制折线 曲线
 *
 * @param pointArr  关键点坐标数组
 * @param width    线宽
 * @param lineAlpha      透明度
 * @param lineColor  线的颜色
 */
+(void)drawBreakenLineWithPointArr:(NSArray * )pointArr lineColor:(UIColor * )lineColor lineWidth:(CGFloat)width lineAlpha:(CGFloat)lineAlpha ;



@end
