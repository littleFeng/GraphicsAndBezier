//
//  BezierView.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BezierView.h"
#import "BezierManager.h"
@implementation BezierView


-(void)drawRect:(CGRect)rect
{
    
    UIFont * font = [UIFont systemFontOfSize:15.0f];
    NSString * string = @"直线 + 虚线 : ";
    [string drawInRect:CGRectMake(16.0f, 80, 100.0f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    
    CGPoint startP = CGPointMake(110 , 90);
    CGPoint endP   = CGPointMake(200, 90);
    [BezierManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor redColor] lineWidth:2.0f duration:1.0f inView:self];
    
    
    
    string = @"圆 + 圆环 + 扇形:";
    [string drawInRect:CGRectMake(16.f, 110.f, 120.f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    [BezierManager drawCircle:CGPointMake(50, 160) withColor:[UIColor greenColor] withRadli:30.f duration:2.0f inView:self];
    [BezierManager drawArcWithCenter:CGPointMake(150, 130) radius:30.f arcWidth:30.f startAngle:0.0f endAngle:M_PI_2 arcColor:[UIColor greenColor] fillColor:[UIColor whiteColor] clockwise:YES duration:3.0f inView:self];
    [BezierManager drawArcWithCenter:CGPointMake(230, 130) radius:30.f arcWidth:20.f startAngle:0.0f endAngle:M_PI *2 arcColor:[UIColor greenColor] fillColor:[UIColor redColor] clockwise:YES duration:3.0f inView:self];

    
    string = @"三角形  面 :";
    [string drawInRect:CGRectMake(16.f, 180.f, 80.f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    CGPoint  point1 = CGPointMake(100, 210.f);
    CGPoint  point2 = CGPointMake(100, 260.f);
    CGPoint  point3 = CGPointMake(150.f,210.f);
    NSMutableArray * array =[NSMutableArray array];
    [array addObject:[NSValue value:&point1 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point2 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point3 withObjCType:@encode(struct CGPoint)]];
    
    
    [array removeAllObjects];
    point1 = CGPointMake(170.f, 210.f);
    point2 = CGPointMake(260.f, 210.f);
    point3 = CGPointMake(260.f, 260.f);
    CGPoint  point4 = CGPointMake(170.f,260.f);
    
    [array addObject:[NSValue value:&point1 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point2 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point3 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point4 withObjCType:@encode(struct CGPoint)]];
    
    string = @"折线 :";
    [string drawInRect:CGRectMake(16.f, 300.f, 80.f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    [array removeAllObjects];
    point1 = CGPointMake(100.f, 330.f);
    point2 = CGPointMake(130.f, 300.f);
    point3 = CGPointMake(160.f, 340.f);
    point4 = CGPointMake(230.f, 320.f);
    [array addObject:[NSValue value:&point1 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point2 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point3 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point4 withObjCType:@encode(struct CGPoint)]];
//    [BezierManager drawBreakenLineWithPointArr:array lineColor:[UIColor redColor] lineWidth:2.0f duration:3.0f inView:self];
    
    [BezierManager drawFillPathWithPointArr:array withColor:[UIColor blueColor] duration:3.0f inView:self];


}

@end
