//
//  ViewController.h
//  CoreGraphicsDemo
//
//  Created by fenglishuai on 15/11/4.
//  Copyright © 2015年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

