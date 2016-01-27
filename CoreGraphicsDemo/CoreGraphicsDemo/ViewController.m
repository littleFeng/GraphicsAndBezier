//
//  ViewController.m
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 15/11/4.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "ViewController.h"
#import "BaseDrawController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _tableView.dataSource =self;
    _tableView.delegate   =self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;

}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType  =UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"CoreGraphics基础绘制";
            break;
        case 1:
            cell.textLabel.text=@"CoreGraphics线图绘制";
            break;
        case 2:
            cell.textLabel.text =@"Bezier基础绘制";
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            BaseDrawController * viewController = [[BaseDrawController alloc]initWithid:@"0"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
        {
            BaseDrawController * viewController = [[BaseDrawController alloc]initWithid:@"1"];
            [self.navigationController pushViewController:viewController animated:YES];
        }

            break;
        case 2:
        {
            BaseDrawController * viewController = [[BaseDrawController alloc]initWithid:@"2"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
