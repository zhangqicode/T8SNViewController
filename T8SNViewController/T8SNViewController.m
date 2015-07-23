//
//  T8SNViewController.m
//  T8SNViewControllerDemo
//
//  Created by 琦张 on 15/7/3.
//  Copyright (c) 2015年 t8. All rights reserved.
//

#import "T8SNViewController.h"

@implementation T8SNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.titleView.alpha = 0;
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.titleView = self.titleView;
    self.titleView.alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

//override
- (void)setupView
{
    //设置statusBar颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //设置navbar按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStyleDone target:self action:nil];
}

//override
- (void)setupStatusOffset:(CGFloat)offset
{
    
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

//override
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
        _headView.backgroundColor = [UIColor colorWithRed:34/255.0 green:179/255.0 blue:5/255.0 alpha:1];
    }
    return _headView;
}

//override
- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.frame = CGRectMake(0, 0, 100, 30);
        _titleView.backgroundColor = [UIColor redColor];
    }
    return _titleView;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView == scrollView) {
        CGFloat offsetY = scrollView.contentOffset.y-(self.headView.frame.size.height-64);
        if (offsetY>0) {
            [self.navigationController.navigationBar setBackgroundImage:[[self class] imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:offsetY/64.0]] forBarMetrics:UIBarMetricsDefault];
            self.titleView.alpha = offsetY/64.0;
            if (offsetY>64) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            }
        }else{
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.titleView.alpha = 0;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
        [self setupStatusOffset:offsetY/64.0];
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
