//
//  NewsTableViewController.m
//  SinaNews
//
//  Created by coly on 14-6-17.
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


#warning 为什么用到这个东西呢，暂时的理解是.h文件使用，.m文件在进行使用采用@class
@class PullTableView;

@interface NewsTableViewController ()<UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>//协议表示其中带一些方法，遵循这个协议才能使用这些方法，问题：如何使用这些协议
#pragma mark int 和 布尔 的类型采用assign在（weak)，NSString 的类型采用copy(strong)
//当前页数
@property (assign, nonatomic) int page;

//总记录数
@property (assign,nonatomic) int count;

//用来判断是不是首次打开，
@property (assign,nonatomic) Boolean isFirst;


@end

@implementation NewsTableViewController
@synthesize newsListArray,page,count,newsListTable,typeName;//属性相对应的写法

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization 定制初始化
        //委托和初始化控件全部放置在这里边
      self.typeName =@"";
      
      self.newsListTable = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];//表视图进行初始化
      
      self.newsListTable.pullBackgroundColor = [UIColor clearColor];//pull表示图的背景颜色
      
      self.tableView = self.newsListTable;//自己写的表视图赋值给系统的表示图
      
      //竟然设置这个就行了，太坑了。。。。。
      self.newsListTable.pullDelegate = self;
      
      self.newsListTable.delegate = self;
      self.newsListTable.dataSource = self;
      
      //去除分割线
      self.newsListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
      
      self.isFirst = YES;//用来判断是不是首次打开
      
     [self.view setBackgroundColor:[UIColor clearColor]];
      
    }
    return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];

  //初始化新闻数组，数组一定要进行初始化，alloc 或者 new 之类的
  self.newsListArray = [NSMutableArray new];
  //self.newsListArray = [[NSMutableArray alloc]initWithObjects:0];
    
}



- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  //如果是首次打开就刷新，不然的话，每次载入视图都不会主动进行刷新的，让界面变为什么也没进行加载过的样子
  if (self.isFirst == YES)
  {
    self.page = 1;
    
    if (self.newsListTable.pullTableIsRefreshing == NO)
    {
      self.newsListTable.pullTableIsRefreshing = YES;
#warning 定时的选择方法;
      [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];//定时进行选择的方法处理,定时处理
    }
#warning 这句话貌似可以删除掉,留着也没用了。
    self.isFirst = NO;
  }
    
#pragma mark 视图将要出现的时候进行调用，没判断出错的话，self.typeName为进行加载过的字段
  self.navigationItem.titleView=[Tools getTtileViewWithTitle:self.typeName andPositionOffset:110.f];
    //+(UIView *)getTtileViewWithTitle:(NSString *)title andPositionOffset:(CGFloat)offset
    //让那个标题自适应屏幕，可以自行居中，模型的概念是控制器传赋值把值拿来，进行具体的修改和我们没什么关系了
}


/**
 *  @brief 刷新数据表
 *
 */
- (void)refreshTable
{
    self.page=1;
    [self.newsListArray removeAllObjects];//数组移除全部的对象,进行新的赋值
    [self getResult];
    
}

- (void)getResult
{
    /*#define requestURL(typeName,pageNo,pagePer) [NSString stringWithFormat:@"http://qingbin.sinaapp.com/api/lists?ntype=%@&pageNo=%d&pagePer=%d&list.htm",typeName,pageNo,pagePer]*/
    //进一步了解到宏定义的使用过程，整体的参数是这样进行书写的
    //self.typeName 的值是通过属性进行传值；其他两个则是本来就有的值
  NSString *url = [NSString stringWithString:requestURL(self.typeName, self.page, perPageNewsCount)];//新闻名字，第几页，每页的数量（加载了几个）
  
  debugLog(@"******%@",url);
#pragma mark 有中文进行转义果然第一次遇见
  //因为url中有中文，这里进行一下url转义
#warning url的中文转义,第一次遇见过
  NSString *encodeURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    debugLog(@"/////%@",encodeURL);
  NSURL *requestUrl = [NSURL URLWithString:encodeURL];//转为URL的类型，打印出来还是没什么变化的，
  NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
#pragma mark 采用第三库的转化 1.下载AFNetworking资源包 https://github.com/AFNetworking/AFNetworking。
 /*
    2.将资源包添加到工程文件。
    
    3.在工程的Supporting File群组中打开预编译头文件XXX-Prefix.pch。然后在别的import后面添加如下一行代码#import “AFNetworking”
    
    将AFNetworking添加到预编译头文件，意味着这个框架会被自动的添加到工程的所有源代码文件中。
    
    4.AFNetworking通过网络来加载和处理结构化的数据非常明智，它支持JSON,XML,Property List。
  
  //添加接收的格式支持，不然html头的json会报错*/
  [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
#warning 异步请求的过程，方法比较简单实用，不愧为异步的过程，get方式吧;
  //一看就是异步请求的过程
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON)
  {
      //解析出来的，一看就是json格式
      NSDictionary*dicWeather = (NSDictionary *)JSON;
      NSLog(@"result:****************%@",dicWeather);
    if (JSON)
    {
      self.count = [[JSON objectForKey:@"total"] intValue];// total = 2772，这个数据总页数
      [self setData:[JSON objectForKey:@"item"]];//每次得到有十个对象，破解这个字典
#warning 整体是一个字典，采用{}来分区,获取关键字total,另外一个对象则是先采用（）封住这个字典，字典里面有{}个对象，每个对象又是一个字典
    }
                                         
  } failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id jj)
  {
    
    [Tools tipWithText:@"亲，网络无连接，请检查网络设置！" andView:self.view];
      //self.view和self.navigation.view的区别呢
      //连接失败后，头和脚的滚动取消了,注意这个添加第三方类库的使用方法;
    self.newsListTable.pullTableIsLoadingMore = NO;
    self.newsListTable.pullTableIsRefreshing = NO;

    debugLog(@"\nThe http request error:%@",error);
  }];
  
 [operation start];
  
}

/**
 *  
 */
#warning 任意类型id JSON 出来的是一段数组，也可以用字典进行存储，字典相当于数组
//- (void)setData:(NSMutableArray *)data
- (void)setData:(NSArray *)data
{
  for (NSDictionary *dict in data) {
#pragma mark 可以直接使用initWithDictionary,创建出实例的方法来进行处理，封装到一个对象里面去
    NewsObject *news = [[NewsObject alloc] initWithDictionary:dict];
    [self.newsListArray addObject:news];
  }
  
  [self.newsListTable reloadData];//数据弄完后表视图进行加装
  
  //在数据表重新加载之后，再把loading状态设置NO
  if (self.newsListTable.pullTableIsRefreshing == YES)
  {
#warning 这个时间能对嘛？
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
#pragma mark 自己注册的自己写
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
    
    if (news.thumb)//判断有地址的存在
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
