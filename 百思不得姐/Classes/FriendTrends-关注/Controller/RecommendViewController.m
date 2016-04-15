//
//  RecommendViewController.m
//  百思不得姐
//
//  Created by 索留元 on 16/4/14.
//  Copyright © 2016年 dianer. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendCategoryCell.h"
#import "RecommendCategory.h"
#import "RecommendUserCell.h"
#import "RecommendUser.h"

#define HLSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]


@interface RecommendViewController ()<UITabBarDelegate,UITableViewDataSource>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 右边的类别数据 */
@property (nonatomic, strong) NSArray *users;
/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;
/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation RecommendViewController
static NSString * const HLCategoryId = @"category";
static NSString * const HLGUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /** 控件初始化 */
    [self setTableView];
    /** 加载左侧数据 */
    [self loadCategory];
    /** 添加刷新控件 */
    [self setUpRefresh];
    
}

- (void)loadCategory
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //服务器返回的json数据
        self.categories = [RecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.categoryTableView reloadData];
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
}
- (void)setUpRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}
/** 控件初始化 */
- (void)setTableView
{
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:HLCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendUserCell class]) bundle:nil] forCellReuseIdentifier:HLGUserId];
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    // 设置背景色
    self.view.backgroundColor = HLGlobalBg;

}
- (void)loadNewUsers
{
    RecommendCategory *rc = HLSelectedCategory;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 发送请求给服务器, 加载右侧的数据
        rc.currentPage = 1;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(rc.id);
        params[@"page"] =@(rc.currentPage);
    
        self.params = params;
    
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //字典数组 -> 模型数组
            NSArray *userArr = [RecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //清除所有旧数据
            [rc.users removeAllObjects];
            // 添加到当前类别对应的用户数组中
            [rc.users addObjectsFromArray:userArr];
            
            // 保存总数
            rc.total = [responseObject[@"total"] integerValue];

            //不是最后一次请求
            if (self.params != params) {
                return;
            }
            
            // 刷新右边的表格
            [self.userTableView reloadData];
            
            //结束刷新
            [self.userTableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (self.params != params) return;
            
            // 提醒
            [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
            
            // 结束刷新
            [self.userTableView.mj_header endRefreshing];
        }];
//    });

}
- (void)loadMoreUsers
{
    RecommendCategory *category = HLSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [RecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];

    
    
}
/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    RecommendCategory *rc = HLSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.categoryTableView){
        return self.categories.count;

    }else{
        // 左边被选中的类别模型
//        RecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        //监测footer状态
        [self checkFooterState];
        
        return [HLSelectedCategory users].count;
    }
   }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        RecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:HLCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
 
    }else
    {
        RecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:HLGUserId];
        // 左边被选中的类别模型
//        RecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = [HLSelectedCategory users][indexPath.row];//c.users[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];

    RecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count > 0) {
        [self.userTableView reloadData];
    }else
    {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];

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
