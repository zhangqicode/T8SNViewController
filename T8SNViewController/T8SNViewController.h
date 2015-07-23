//
//  T8SNViewController.h
//  T8SNViewControllerDemo
//
//  Created by 琦张 on 15/7/3.
//  Copyright (c) 2015年 t8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T8SNViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *titleView;

@end
