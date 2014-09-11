//
//  NewsTableViewController.m
//  SinaNews
//
//  Created by coly on 13-6-17.
//  Copyright (c) 2013年 coly. All rights reserved.
//
/*http://qingbin.sinaapp.com/api/lists?ntype=图片&pageNo=1&pagePer=10&list.htm，解析出来东西
 {"total":2772,"item":[{"id":"110396","title":"\u6559\u5e08\u5c06\u6bdb\u6cfd\u4e1c\u6c42\u5b66\u65f6\u81ea\u521b\u4f53\u64cd\u6539\u7f16\u4e3a\u5e7f\u573a\u821e","ntype":null,"addtime":null,"thumb":"http:\/\/img5.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UQ691V900AP0001.jpg"},{"id":"110379","title":"\u72f1\u8b66\u4eec\u7684\u7236\u4eb2\u8282","ntype":null,"addtime":null,"thumb":"http:\/\/img5.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPQFKUI57KT0001.JPG"},{"id":"110353","title":"\u8d70\u8fdb\u65e5\u672c\u9189\u6c49\u7684\u4e16\u754c \u65e5\u672c\u5de5\u85aa\u65cf\u751f\u6d3b\u53e6\u4e00\u9762","ntype":null,"addtime":null,"thumb":"http:\/\/img4.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPE5V944T8F0001.jpg"},{"id":"110352","title":"\u5317\u4eac\u5e7c\u513f\u56ed\u62db\u751f \u8001\u4eba\u51cc\u6668\u6392\u961f\u7b49\u62a5\u540d","ntype":null,"addtime":null,"thumb":"http:\/\/img6.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPDSO5500AP0001.jpg"},{"id":"110354","title":"1600\u53ea\u7eb8\u718a\u732b\u73af\u6e38\u4e16\u754c \u547c\u5401\u4fdd\u62a4\u6fd2\u5371\u52a8\u7269","ntype":null,"addtime":null,"thumb":"http:\/\/img3.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPD9MMF4T8F0001.jpg"},{"id":"110355","title":"\u7f8e\u56fd18\u5c81\u5973\u5b69\u9177\u4f3c\u8fea\u58eb\u5c3c\u51b0\u96ea\u5973\u738b","ntype":null,"addtime":null,"thumb":"http:\/\/img3.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPD45IJ00AO0001.jpg"},{"id":"110356","title":"\u6614\u65e5\u4e16\u754c\u676f\u7403\u661f\u73b0\u72b6 \u5f88\u591a\u4ecd\u6d3b\u8dc3\u5728\u8db3\u575b","ntype":null,"addtime":null,"thumb":"http:\/\/img4.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPCU8V14T8F0001.jpg"},{"id":"110344","title":"\u4e2d\u56fd\u6d77\u519b\u8230\u961f\u62b5\u8fbe\u5173\u5c9b\u4e0e\u7f8e\u56fd\u6d77\u519b\u4f1a\u5408","ntype":null,"addtime":null,"thumb":"http:\/\/img3.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPAD2864T8E0001.jpg"},{"id":"110345","title":"\u4e4c\u514b\u5170\u4f0a\u5c14-76\u5760\u6bc1\u73b0\u573a\u66dd\u5149 \u9020\u621040\u4f1e\u5175\u6b7b\u4ea1","ntype":null,"addtime":null,"thumb":"http:\/\/img3.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UPACH4Q56NT0001.jpg"},{"id":"110328","title":"\u4f26\u6566\u4e3e\u884c\u88f8\u9a91\u6d3b\u52a8 \u547c\u5401\u7eff\u8272\u51fa\u884c","ntype":null,"addtime":null,"thumb":"http:\/\/img6.cache.netease.com\/photo\/0001\/2014-06-15\/900x600_9UP6LF1G00AO0001.jpg"}]}*/
#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "NewsObject.h"
#import "NewsDetailViewController.h"
#import "Tools.h"


#warning 为什么用到这个东西呢
@class PullTableView;

@interface NewsTableViewController ()<UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>
#pragma mark int 和 布尔 的类型采用assign，NSString 的类型采用copy
//当前页数
@property (assign, nonatomic) int page;

//总记录数
@property (assign,nonatomic) int count;

//用来判断是不是首次打开，
@property (assign,nonatomic) Boolean isFirst;


@end

@implementation NewsTableViewController
@synthesize newsListArray,page,count,newsListTable,typeName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //委托和初始化控件全部放置在这里边
      self.typeName =@"";
      
      self.newsListTable = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
      
      self.newsListTable.pullBackgroundColor = [UIColor clearColor];
      
      self.tableView = self.newsListTable;
      
      //竟然设置这个就行了，太坑了。。。。。
      self.newsListTable.pullDelegate = self;
      
      self.newsListTable.delegate = self;
      self.newsListTable.dataSource = self;
      
      //去除分割线
      self.newsListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
      
      self.isFirst = YES;
      
     [self.view setBackgroundColor:[UIColor clearColor]];
      
    }
    return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];

  //初始化新闻数组，数组一定要进行初始化，alloc 或者 new 之类的
  self.newsListArray = [NSMutableArray new];
}



- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //如果是首次打开就刷新，不然的话，每次载入视图都会刷新的
  if (self.isFirst == YES)
  {
    self.page = 1;
    
    if (self.newsListTable.pullTableIsRefreshing == NO)
    {
      self.newsListTable.pullTableIsRefreshing = YES;
      [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
    self.isFirst = NO;
  }
    
#pragma mark 视图将要出现的时候进行调用
  self.navigationItem.titleView=[Tools getTtileViewWithTitle:self.typeName andPositionOffset:110.f];
    //+(UIView *)getTtileViewWithTitle:(NSString *)title andPositionOffset:(CGFloat)offset
    //让那个标题自适应屏幕，可以自行居中
}


/**
 *  @brief 刷新数据表
 *
 */
- (void)refreshTable
{
    self.page=1;
    [self.newsListArray removeAllObjects];
    [self getResult];
    
}

- (void)getResult
{
  NSString *url = [NSString stringWithString:requestURL(self.typeName, self.page, perPageNewsCount)];//新闻名字，第几页，每页的数量
  
  debugLog(@"******%@",url);
#pragma mark 有中文进行转义果然第一次遇见
  //因为url中有中文，这里进行一下url转义
  NSString *encodeURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    debugLog(@"/////%@",encodeURL);
  NSURL *requestUrl = [NSURL URLWithString:encodeURL];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
#pragma mark 采用第三库的转化 1.下载AFNetworking资源包 https://github.com/AFNetworking/AFNetworking。
 /*
    2.将资源包添加到工程文件。
    
    3.在工程的Supporting File群组中打开预编译头文件XXX-Prefix.pch。然后在别的import后面添加如下一行代码#import “AFNetworking”
    
    将AFNetworking添加到预编译头文件，意味着这个框架会被自动的添加到工程的所有源代码文件中。
    
    4.AFNetworking通过网络来加载和处理结构化的数据非常明智，它支持JSON,XML,Property List。
  //添加接收的格式支持，不然html头的json会报错*/
  [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON)
  {
      //
      NSDictionary*dicWeather = (NSDictionary *)JSON;
      NSLog(@"result:****************%@",dicWeather);
    if (JSON)
    {
      self.count = [[JSON objectForKey:@"total"] intValue];
      [self setData:[JSON objectForKey:@"item"]];

    }
                                         
  } failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id jj)
  {
    
    [Tools tipWithText:@"亲，网络无连接，请检查网络设置！" andView:self.navigationController.view];
    self.newsListTable.pullTableIsLoadingMore = NO;
    self.newsListTable.pullTableIsRefreshing = NO;

    debugLog(@"\nThe http request error:%@",error);
  }];
  
  [operation start];
  
}

/**
 *  
 */
- (void)setData:(NSDictionary *)data
{
  for (NSDictionary *dict in data) {
    NewsObject *news = [[NewsObject alloc] initWithDictionary:dict];
    [self.newsListArray addObject:news];
  }
  
  [self.newsListTable reloadData];
  
  //在数据表重新加载之后，再把loading状态设置NO
  if (self.newsListTable.pullTableIsRefreshing == YES)
  {
    self.newsListTable.pullLastRefreshDate = [NSDate date];
  }
  self.newsListTable.pullTableIsLoadingMore = NO;
  self.newsListTable.pullTableIsRefreshing = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.newsListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NewsCellIdentifier = @"NewsCellIdentifier";
    NewsCell *cell = [self.newsListTable dequeueReusableCellWithIdentifier:NewsCellIdentifier];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewsCellIdentifier];
    }
  

    // Configure the cell...
  
  NSInteger row = [indexPath row];
  
  //这里判断一下当前的news数组是不是已经加载进来了，如果不判断，会报错
  if (row <= [self.newsListArray count])
  {
    NewsObject *news = [self.newsListArray objectAtIndex:row];
    
    cell.newsTitle.text = news.title;
    cell.newsPublishDate.text = news.addTime;
    
    if (news.thumb)
    {
      [cell.newsThumb setImageWithURL:[NSURL URLWithString:news.thumb] placeholderImage:[UIImage imageNamed:@"cell_photo_default_small.png"]];
    }
  }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return newsCellHeight;
}




#pragma mark  - pullRefreshTable methods



/**
 *  @brief 载入更多
 *
 */
- (void)loadMoreToTable
{
  //判断一下总页数，超出不再请求
  if (ceil(self.count/perPageNewsCount)< self.page)
  {
    [Tools tipWithText:@"没有更多数据了！" andView:self.navigationController.view];
    self.newsListTable.pullTableIsLoadingMore = NO;
    self.newsListTable.pullTableIsRefreshing = NO;
  }else
  {
    self.page++;
    [self getResult];
  }
}


#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
  [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
  [self performSelector:@selector(loadMoreToTable) withObject:nil afterDelay:1.0f];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSUInteger row = [indexPath row];
  NewsObject *news = [self.newsListArray objectAtIndex:row];
  int newsId = news.id;
  NewsDetailViewController *newsDetail = [[NewsDetailViewController alloc] initWithNibName:@"NewsDetailViewController" bundle:nil];
  [newsDetail loadWebViewFromNewsId:newsId andSetViewTitle:news.title];
  [self.navigationController pushViewController:newsDetail animated:YES];
}

@end
