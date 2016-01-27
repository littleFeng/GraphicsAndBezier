//
//  LSChartView.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "GraphicsManager.h"
#import "LSChartView.h"
static CGFloat topOff = 20.0f;
static CGFloat leftOff = 10.0f;
static CGFloat rightOff = 10.0f;
static CGFloat bottomOff = 20.0f;
@interface LSChartView ()

@property(nonatomic,strong) NSMutableArray * valueArray_x;

@property(nonatomic,strong) NSMutableArray * valueArray_y;

@property(nonatomic,strong) NSMutableArray * displayArr_x;

@property(nonatomic,strong) NSMutableArray * displayArr_y;

@property(nonatomic,strong) NSMutableArray * pointArray;

@property(nonatomic,strong) NSMutableArray * shadowPointArr;

@property(nonatomic,assign) CGFloat   pointDis_x;

@property(nonatomic,assign) CGFloat   pointDis_y;

@property(nonatomic,assign) CGFloat   showValueDis_x;

@property(nonatomic,assign) CGFloat   showValueDis_y;

@property(nonatomic,assign) CGFloat   max_Y;

@property(nonatomic,assign) CGFloat   minY;

@property(nonatomic,assign) NSInteger displayCount_x;

@property(nonatomic,assign) NSInteger displayCount_y;

@property(nonatomic,assign) CGFloat   displayValueDis_x;

@property(nonatomic,assign) CGFloat   displayVlaueDis_y;

@property(nonatomic,assign) CGRect    drawRect; //!<< 绘图区域

@property(nonatomic,assign) BOOL      isShowLine;

@property(nonatomic,assign) NSInteger currentIndex;

@end


@implementation LSChartView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _isNeedRedraw = YES;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [self transformDataToPoint];
}
-(void)transformDataToPoint
{
    if(_isNeedRedraw)
    {
    if(!_valueArray_x )
        _valueArray_x = [NSMutableArray arrayWithCapacity:3];
    else
        [_valueArray_x removeAllObjects];
    
    if(!_valueArray_y)
        _valueArray_y = [NSMutableArray arrayWithCapacity:3];
    else
        [_valueArray_y removeAllObjects];
    
    if(!_pointArray)
        _pointArray =[NSMutableArray arrayWithCapacity:3];
    else
        [_pointArray removeAllObjects];
    
    if(!_shadowPointArr)
        _shadowPointArr = [NSMutableArray arrayWithCapacity:3];
    else
        [_shadowPointArr removeAllObjects];
    
    if(!_displayArr_x)
        _displayArr_x = [NSMutableArray arrayWithCapacity:3];
    else
        [_displayArr_x removeAllObjects];
    
    if(!_displayArr_y)
        _displayArr_y = [NSMutableArray arrayWithCapacity:3];
    else
        [_displayArr_y removeAllObjects];
    
    if(!_dateSource || ![_dateSource respondsToSelector:@selector(dataOfValueForXAxisInLsChartView:)])
        return;
    if(!_dateSource || ![_dateSource respondsToSelector:@selector(dataOFValueForYAxisInLsChartView:)])
        return;
    if(!_dateSource || ![_dateSource respondsToSelector:@selector(valueOfMaxYInLsChartView:)])
        return;
    if(!_dateSource || ![_dateSource respondsToSelector:@selector(valueOfMinYInLsChartView:)])
        return;
    if(!_dateSource || ![_dateSource respondsToSelector:@selector(showValueArrForXAxisInLsChartView:)])
        return;
    if(!_dateSource || ![_dateSource respondsToSelector:@selector(numberOfShowValueForYAxisInLsChartView:)])
        return;
        
    _valueArray_x = [[_dateSource dataOfValueForXAxisInLsChartView:self] mutableCopy];
    if(!_valueArray_x || _valueArray_x.count== 0)
        return;
    _valueArray_y = [[_dateSource dataOFValueForYAxisInLsChartView:self] mutableCopy];
    if(!_valueArray_y|| _valueArray_y.count ==0 )
        return;
    
    _max_Y =  [_dateSource valueOfMaxYInLsChartView:self];
    _minY  =  [_dateSource valueOfMinYInLsChartView:self];
    
    _displayCount_y = [_dateSource numberOfShowValueForYAxisInLsChartView:self];
    _displayVlaueDis_y = (_max_Y -_minY) / (CGFloat) _displayCount_y;

    UIFont * font = [UIFont systemFontOfSize:9.0f];
    NSDictionary * dic = @{NSFontAttributeName : font,
                           NSForegroundColorAttributeName:[UIColor blackColor],
                           NSBackgroundColorAttributeName:[UIColor redColor]};
    NSString * string_y = [NSString stringWithFormat:@"%.3f",_displayVlaueDis_y];
    CGSize   size = [string_y sizeWithAttributes:dic];
    
    CGFloat height = CGRectGetHeight(self.frame)-topOff - bottomOff;
    CGFloat width  = CGRectGetWidth(self.frame)-leftOff - rightOff-2*size.width;
    if(_dateSource && [_dateSource respondsToSelector:@selector(numberOfPointsForXaxisInLsChartView:)])
        _pointDis_x = (width/[_dateSource numberOfPointsForXaxisInLsChartView:self]);
    else
        _pointDis_x = (width / _valueArray_x.count);
    
    if(_dateSource && [_dateSource respondsToSelector:@selector(numberOFpointsForYAxisInLsChartView:)])
        _pointDis_y = (height / [_dateSource numberOfShowValueForYAxisInLsChartView:self]);
    else
        _pointDis_y = (height / (_max_Y - _minY));
    
    _drawRect =  CGRectMake(leftOff + size.width, topOff, width, height);
    
    
   //TODO: draw X and Y axis
    for(NSInteger i = 0 ; i< _displayCount_y;i++)
    {
        
        CGFloat end_y =CGRectGetMinY(_drawRect) +CGRectGetHeight(_drawRect)/(CGFloat)_displayCount_y * i;
        
        NSString * string_y =[NSString stringWithFormat:@"%.3f",[NSNumber numberWithFloat:(_max_Y - _displayVlaueDis_y * i)].floatValue];
        CGRect rect = CGRectMake(leftOff, end_y-size.height * 0.5f, size.width, size.height);
        [string_y drawInRect:rect withAttributes:dic];
        
        CGPoint startP = CGPointMake(CGRectGetMinX(_drawRect), end_y);
        CGPoint endP  = CGPointMake(CGRectGetMaxX(_drawRect),end_y);
        [GraphicsManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor grayColor] lineWidth:1.0f lineAlpha:0.1f dashLength:5.f];
    }
    
    _displayArr_x = [[_dateSource showValueArrForXAxisInLsChartView:self] mutableCopy];
    for(NSInteger i =0;i<_displayArr_x.count;i++)
    {
        CGFloat end_x =leftOff+size.width +(CGRectGetWidth(_drawRect) / ( _displayArr_x.count-1))* i;
        CGSize size_x = [_displayArr_x[i] sizeWithAttributes:dic];
        CGRect rect = CGRectMake( end_x- size_x.width*0.5f,CGRectGetMaxY(_drawRect)+3.0f, size_x.width, size_x.height);
        [_displayArr_x[i] drawInRect:rect withAttributes:dic];
        
        CGPoint startP = CGPointMake(end_x, topOff);
        CGPoint endP  = CGPointMake(end_x, CGRectGetMaxY(_drawRect));
        [GraphicsManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor grayColor] lineWidth:1.0f lineAlpha:0.1f dashLength:5.f];
    }
    
    //TODO:transform value to point  draw fill path  and stroke path
    for(NSInteger i =0 ; i < _valueArray_x.count ; i++)
    {
        if(i >= _valueArray_y.count)
            return;
        CGFloat value_y = [(NSNumber * )_valueArray_y[i] floatValue];
        CGPoint drawPoint = CGPointZero;
        
        drawPoint = CGPointMake(CGRectGetMinX(_drawRect)+ _pointDis_x * i , topOff+(_max_Y - value_y) * _pointDis_y);
        [_pointArray addObject:[NSValue value:&drawPoint withObjCType:@encode(struct CGPoint)]];
        
        if(i==0 )
        {
           CGPoint point = CGPointMake(drawPoint.x, CGRectGetHeight(_drawRect) + topOff);
            [_shadowPointArr addObject:[NSValue value:&point withObjCType:@encode(struct CGPoint)]];
        }
        
        [_shadowPointArr addObject:[NSValue value:&drawPoint withObjCType:@encode(struct CGPoint)]];
        if(i == _valueArray_y.count -1)
        {
            CGPoint point = CGPointMake(drawPoint.x, CGRectGetHeight(_drawRect) + topOff);
            [_shadowPointArr addObject:[NSValue value:&point withObjCType:@encode(struct CGPoint)]];
        }
    }
    [GraphicsManager drawFillPathWithPointArr:_shadowPointArr withColor:[UIColor blueColor] fillAlpha:0.3f];
    [GraphicsManager drawBreakenLineWithPointArr:_pointArray lineColor:[UIColor blackColor] lineWidth:1.0f lineAlpha:0.5f];
    }
    
    if(_isShowLine)
    {
        UIFont * font = [UIFont systemFontOfSize:9.0f];
        NSDictionary * dic = @{NSFontAttributeName : font,
                               NSForegroundColorAttributeName:[UIColor blackColor],
                               NSBackgroundColorAttributeName:[UIColor redColor]};
        NSString * string_y = [NSString stringWithFormat:@"%.4f",_displayVlaueDis_y];
        CGSize   size = [string_y sizeWithAttributes:dic];
        
        NSDictionary * dic0 = @{NSFontAttributeName : font,
                               NSForegroundColorAttributeName:[UIColor blackColor],
                               NSBackgroundColorAttributeName:[UIColor blueColor]};
        CGPoint point = CGPointZero;
        [[_pointArray objectAtIndex:_currentIndex] getValue:&point];
        
        CGPoint startP = CGPointMake(point.x, CGRectGetMinY(_drawRect));
        CGPoint endP   = CGPointMake(point.x, CGRectGetMaxY(_drawRect));
        
        [GraphicsManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor redColor] lineWidth:0.5f lineAlpha:0.5f dashLength:0];
        
        NSString * value_x = [_valueArray_x objectAtIndex:_currentIndex];
        [value_x drawInRect:CGRectMake(point.x - size.width*0.5f, CGRectGetMaxY(_drawRect)-size.height, size.width, size.height) withAttributes:dic0];
        
        startP = CGPointMake(CGRectGetMinX(_drawRect), point.y);
        endP   = CGPointMake(CGRectGetMaxX(_drawRect), point.y);
        
        [GraphicsManager drawLineWithstartPoint:startP endPoint:endP lineColor:[UIColor redColor] lineWidth:0.5f lineAlpha:0.5f dashLength:0];
        
        NSString * value_y = [_valueArray_y objectAtIndex:_currentIndex];
        [value_y drawInRect:CGRectMake(CGRectGetMaxX(_drawRect), point.y - size.height*0.5f, size.width, size.height) withAttributes:dic0];
        
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches  anyObject] locationInView:self];
    if(CGRectContainsPoint(_drawRect, location))
    {
        CGFloat dis = location.x - CGRectGetMinX(_drawRect);
        NSInteger intValue  = (dis / _pointDis_x);
        NSInteger index = intValue + ((dis- _pointDis_x * intValue )>(_pointDis_x * 0.5f)?1:0);
        if(index >= _valueArray_x.count)
            return;
        [self drawPointLine:index];
        if(_dateSource && [_dateSource respondsToSelector:@selector(LsChartView:didMoveFingerInDataIndex:)])
        {
            [_dateSource LsChartView:self didMoveFingerInDataIndex:index];
        }
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _isShowLine = NO;
    [self setNeedsDisplay];

}
-(void)drawPointLine:(NSInteger)index
{
    _currentIndex = index;
    _isShowLine   = YES;
    [self setNeedsDisplay];
}
@end
