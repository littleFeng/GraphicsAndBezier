//
//  BaseDrawController.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 16/1/15.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BaseDrawController.h"
#import "UIView+SDAutoLayout.h"
#import "TestView.h"
#import "LSChartView.h"
#import "BezierView.h"
@interface BaseDrawController ()
<dataSource>
@property(nonatomic,strong) NSString * type;
@end

@implementation BaseDrawController
{
    NSMutableArray * valueArray_x;
    NSMutableArray * valueArray_y;
    CGFloat maxY;
    CGFloat minY;

    LSChartView * view;
    UIButton * button0;
    UIButton * button1;
    
}

-(id)initWithid:(NSString * )type;
{
    self = [super init];
    if(self)
    {
        _type = type;
        
    }
    NSLog(@"1");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ss) name:UIDeviceOrientationDidChangeNotification object:nil];
    return self;
}

-(void)ss
{
    view.isNeedRedraw= YES;
    [view setNeedsDisplay];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"3");
    [super viewDidAppear:animated];

}
- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];

    
        NSLog(@"2");
    NSInteger t = [_type integerValue];
    
    switch (t) {
        case 0:
        {
            TestView * view0 = [[TestView alloc]initWithFrame:self.view.frame];
            view0.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view0];
        }
            break;
        case 1:
        {
            [self test];
            view = [[LSChartView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
            view.dateSource=self;
            [self.view addSubview:view];
            button0.sd_layout
            .leftSpaceToView(self.view, 30)
            .topSpaceToView(self.view,70.f)
            .widthIs(120.0)
            .heightIs(30.0);
            
            button1.sd_layout
            .leftSpaceToView(button0,30.f)
            .topEqualToView(button0)
            .widthIs(120.f)
            .heightIs(30.f);
        
            view.sd_layout
            .leftSpaceToView(self.view,15.0f)
            .rightSpaceToView(self.view,15.0f)
            .topSpaceToView(button0,10.0f)
            .bottomSpaceToView(self.view,80.0f);
            [view setNeedsDisplay];
            break;
            
        }
        case 2:
        {
            BezierView * view_b = [[BezierView alloc]initWithFrame:self.view.frame];
            view_b.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view_b];
            break;
        }
            
            
        default:
            break;
    }
    
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
}
-(void)test
{
    button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button0 setTitle:@"全部数据绘制" forState:UIControlStateNormal];
    [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(button0Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"部分数据绘制" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    [self loadDataName:@"data"];
    
}
-(void)button0Action:(id)sender
{
    [self loadDataName:@"data"];
    view.isNeedRedraw = YES;
    [view setNeedsDisplay];
    
}
-(void)button1Action:(id)sender
{
    [self loadDataName:@"data2"];
    view.isNeedRedraw =YES;
    [view setNeedsDisplay];

}
-(void)loadDataName:(NSString * )name
{
    valueArray_x = [NSMutableArray array];
    valueArray_y = [NSMutableArray array];
    
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSData   * data = [NSData dataWithContentsOfFile:jsonPath];
    
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray * rateArr = [arr objectAtIndex:0];
    
    NSNumber * index=[rateArr objectAtIndex:1];
    
    maxY = minY =index.floatValue;
    
    for (NSInteger i = 0; i < arr.count; ++i)
    {
        NSArray * pWeekRateArr = [arr objectAtIndex:i];
        
        NSNumber * index1=[pWeekRateArr objectAtIndex:1];
        
        if (!index1 || [index1 isKindOfClass:[NSNull class]])
        {
            continue;
        }
        NSString *rate = index1.stringValue;
        NSNumber * range=[pWeekRateArr objectAtIndex:2];
        NSTimeInterval time = [[pWeekRateArr objectAtIndex:0]doubleValue];//1970年到现在的豪秒
        NSString* dateString = [self dateFormate:time];
        [valueArray_y addObject:rate];
        [valueArray_x addObject:dateString];
        
        //
        if(index1.floatValue > maxY)
            maxY = index1.floatValue;
        
        if(index1.floatValue < minY)
            minY = index1.floatValue;
    }
    
}
-(NSString *)dateFormate:(NSTimeInterval )time
{
    time = time/1000;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * formateer = [[NSDateFormatter alloc]init];
    [formateer setDateFormat:@"HH:mm"];
    return [formateer stringFromDate:date];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//X轴
-(NSArray * )dataOfValueForXAxisInLsChartView:(LSChartView *)view
{
    return valueArray_x;
}

-(NSArray * )showValueArrForXAxisInLsChartView:(LSChartView *)view
{
    return @[@"9:30",@"10:30",@"11:00/13:00",@"14:00",@"15:00"];
}

-(NSInteger)numberOfPointsForXaxisInLsChartView:(LSChartView *)view
{
    return 242;

}
//Y轴
-(NSInteger)numberOfShowValueForYAxisInLsChartView:(LSChartView *)view
{
    return 5.0f;
}
-(NSArray * )dataOFValueForYAxisInLsChartView:(LSChartView *)view
{
    return valueArray_y;
}
-(CGFloat)valueOfMaxYInLsChartView:(LSChartView *)view
{
    return  maxY;
}
-(CGFloat)valueOfMinYInLsChartView:(LSChartView *)view
{
    return  minY-0.01;
}

-(void)LsChartView:(LSChartView *)view didMoveFingerInDataIndex:(NSInteger)index
{
    NSLog(@"index===%@",@(index).stringValue);
    
    NSLog(@"x=======%@",[valueArray_x objectAtIndex:index]);
    
    NSLog(@"y========%@",[valueArray_y objectAtIndex:index]);

}

-(void)dealloc
{
    NSLog(@"delloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
