//
//  BaseDrawController.h
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/15.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,viewType)
{
    baseDraw = 0,
    chartView =1,
    bezierDraw=2
};

@interface BaseDrawController : UIViewController


-(id)initWithid:(NSString * )type;


@end
