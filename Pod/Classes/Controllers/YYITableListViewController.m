//
//  YYITableListViewController.m
//  GoldWallet
//
//  Created by 丁玉松 on 15/7/15.
//  Copyright (c) 2015年 Beijing Yingyan Internet Co., Ltd. All rights reserved.
//

#import "YYITableListViewController.h"


@interface YYITableListViewController ()
{
    BOOL isRefershing;
}
@end

@implementation YYITableListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestArraySize  = 10;
    self.isHaveFooterRefersh = YES;
    // Do any additional setup after loading the view.
}

-(void)setupRefresh
{
    
    self.tableView_par.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    if (self.isHaveFooterRefersh) {
        self.tableView_par.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    [self.tableView_par.header beginRefreshing];
    
    //    [self.tableView_par.header setTitle:@"下拉刷新" forState:MJRefreshHeaderStatePulling];
    //    [self.tableView_par.header setTitle:@"松开刷新" forState:MJRefreshHeaderStateWillRefresh];
    //    [self.tableView_par.header setTitle:@"正在刷新中,稍等片刻" forState:MJRefreshHeaderStateRefreshing];
    //
    //    [self.tableView_par.footer setTitle:@"下拉刷新" forState:MJRefreshFooterStateIdle];
    //    [self.tableView_par.footer setTitle:@"正在刷新中,稍等片刻" forState:MJRefreshFooterStateRefreshing];
    //    [self.tableView_par.footer setTitle:@"淡定淡定，没有数据啦" forState:MJRefreshFooterStateNoMoreData];
    
}

//下拉刷新
-(void)headerRereshing
{
    if (isRefershing) {
        return;
    }
    
    isRefershing = YES;
    self.isCanLoadMore = YES;
    self.isHeadRefersh = YES;
    [self loadlistData];
    [self.tableView_par.footer resetNoMoreData];
}

-(void)footerRereshing
{
    if (isRefershing) {
        return;
    }
    
    isRefershing = YES;
    if (self.isCanLoadMore) {
        self.isHeadRefersh = NO;
        [self loadlistData];
    }
    else
    {
        [self.tableView_par.footer noticeNoMoreData];
    }
}


-(void)loadlistData
{

}



-(void)endRefershWithArray:(NSArray *)array
{
    
    if (array.count < self.requestArraySize || array == nil) {
        self.isCanLoadMore = NO;
        [self.tableView_par.footer noticeNoMoreData];
    }
}

-(void)endRefershing
{
    isRefershing = NO;
    if (self.isHeadRefersh) {
        [self.tableView_par.header endRefreshing];
    }
    else
    {
        [self.tableView_par.footer endRefreshing];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
