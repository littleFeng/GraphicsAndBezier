//
//  LSChartView.h
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSChartView;

@protocol dataSource <NSObject>
@required
//X轴
-(NSArray * )dataOfValueForXAxisInLsChartView:(LSChartView * )view;
-(NSArray * )showValueArrForXAxisInLsChartView:(LSChartView * )view;
-(NSInteger)numberOfPointsForXaxisInLsChartView:(LSChartView * )view;
//Y轴
-(NSInteger)numberOfShowValueForYAxisInLsChartView:(LSChartView * )view;
-(NSArray * )dataOFValueForYAxisInLsChartView:(LSChartView * )view;
-(CGFloat)valueOfMaxYInLsChartView:(LSChartView * )view;
-(CGFloat)valueOfMinYInLsChartView:(LSChartView * )view;

@optional
-(NSInteger)numberOFpointsForYAxisInLsChartView:(LSChartView * )view;

//手指移动时的回调
-(void)LsChartView:(LSChartView * )view didMoveFingerInDataIndex:(NSInteger)index ;

@end


@interface LSChartView : UIView
@property(nonatomic,weak)id<dataSource>dateSource;
@property(nonatomic,assign) BOOL isNeedRedraw;//!<<是否需要重绘
@end
