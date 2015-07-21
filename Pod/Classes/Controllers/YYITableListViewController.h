//
//  YYITableListViewController.h
//  GoldWallet
//
//  Created by 丁玉松 on 15/7/15.
//  Copyright (c) 2015年 Beijing Yingyan Internet Co., Ltd. All rights reserved.
//

#import "RootViewController.h"
#import <MJRefresh.h>

@interface YYITableListViewController : RootViewController

@property (nonatomic,strong) UITableView *tableView_par;
@property (nonatomic,assign) BOOL isHeadRefersh;
@property (nonatomic,assign) BOOL isCanLoadMore;
@property (nonatomic,assign) NSInteger requestArraySize;
@property (nonatomic,assign) BOOL isHaveFooterRefersh;


//结束刷新（判断是否有跟多）
-(void)endRefershWithArray:(NSArray *)array;
//设置上拉下拉刷新
-(void)setupRefresh;
//下载数据
-(void)loadlistData;
//结束刷新
-(void)endRefershing;

@end
