//
//  TestView.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 15/11/4.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "TestView.h"
@implementation TestView

-(void)drawRect:(CGRect)rect
{
    UIFont * font = [UIFont systemFontOfSize:15.0f];
    NSString * string = @"直线 + 虚线 : ";
    [string drawInRect:CGRectMake(16.0f, 80, 100.0f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    
    CGPoint startP = CGPointMake(110 , 90);
    CGPoint endP   = CGPointMake(200, 90);
    [GraphicsManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor redColor] lineWidth:1.0f lineAlpha:0.5f dashLength:.0f ];
    startP = CGPointMake(250, 90);
    endP   = CGPointMake(300, 90);
    [GraphicsManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor redColor] lineWidth:1.0f lineAlpha:1.0f dashLength:10.0f];
    
    string = @"圆 + 圆环 + 扇形:";
    [string drawInRect:CGRectMake(16.f, 110.f, 120.f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    
    [GraphicsManager drawCircle:CGPointMake(80, 150.f) withColor:[UIColor greenColor] withRadli:20.0f];
    [GraphicsManager drawDonut:CGPointMake(150, 150.f) withInColor:[UIColor redColor] withOutColor:[UIColor blueColor] withRadMin:10.f withRadMax:20.f];
    [GraphicsManager drawArcWithCenter:CGPointMake(200.f, 140.f) radius:30.0f startAngle:0.0f endAngle:M_PI_2 lineWidth:2.0f lineColor:[UIColor greenColor] fillColor:[UIColor redColor] clockwise:NO];

    
    string = @"三角形  面 :";
    [string drawInRect:CGRectMake(16.f, 180.f, 80.f, 30.f) withAttributes:@{NSFontAttributeName:font}];
    CGPoint  point1 = CGPointMake(100, 210.f);
    CGPoint  point2 = CGPointMake(100, 260.f);
    CGPoint  point3 = CGPointMake(150.f,210.f);
    NSMutableArray * array =[NSMutableArray array];
    [array addObject:[NSValue value:&point1 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point2 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point3 withObjCType:@encode(struct CGPoint)]];
    [GraphicsManager DrawpathWithPointArr:array withColor:[UIColor redColor] withLineColor:[UIColor greenColor] withFillAlpha:0.5f lineAlpha:0.5f borderWidth:1.0f];
    
    [array removeAllObjects];
      point1 = CGPointMake(170.f, 210.f);
      point2 = CGPointMake(260.f, 210.f);
      point3 = CGPointMake(260.f, 260.f);
    CGPoint  point4 = CGPointMake(170.f,260.f);

    [array addObject:[NSValue value:&point1 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point2 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point3 withObjCType:@encode(struct CGPoint)]];
    [array addObject:[NSValue value:&point4 withObjCType:@encode(struct CGPoint)]];
    [GraphicsManager drawFillPathWithPointArr:array withColor:[UIColor redColor] fillAlpha:0.5f];
    
    
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
    [GraphicsManager drawBreakenLineWithPointArr:array lineColor:[UIColor redColor] lineWidth:1.0f lineAlpha:0.3f];
    [GraphicsManager drawDonut:point2 withInColor:[UIColor whiteColor] withOutColor:[UIColor redColor] withRadMin:2.0f withRadMax:5.0f];
    [GraphicsManager drawDonut:point3 withInColor:[UIColor whiteColor] withOutColor:[UIColor redColor] withRadMin:2.0f withRadMax:5.0f];
}

@end
