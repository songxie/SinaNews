//
//  NewsTableViewController.m
//  SinaNews
//
//  Created by coly on 13-6-17.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "newsObject.h"

@interface NewsTableViewController ()<UITableViewDataSource, UITableViewDelegate, PullTableViewDelegate>

//当前页数
@property (assign, nonatomic) int page;

//总记录数
@property (assign,nonatomic) int count;


@end

@implementation NewsTableViewController
@synthesize newsListTable,newsListArray,page,count;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
      
      
      
      self.newsListTable = [[PullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
      
      self.tableView = self.newsListTable;
      
      self.newsListTable.delegate = self;
      self.newsListTable.dataSource = self;
      
      //去除分割线
      self.newsListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
      
      
     [self.view setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"头条";
  
  self.newsListArray = [NSMutableArray new];
  
  self.newsListTable.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
  self.newsListTable.pullBackgroundColor = [UIColor clearColor];
  self.newsListTable.pullTextColor = [UIColor blackColor];

}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.page = 1;
  if (self.newsListTable.pullTableIsRefreshing == NO)
  {
    self.newsListTable.pullTableIsRefreshing = YES;
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
  }
}

- (void)getResult
{
  NSURL *requestUrl = [NSURL URLWithString:@"http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
  
  [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSURLResponse *response, id JSON)
  {
    
    if (JSON)
    {
      self.count = [[JSON objectForKey:@"count"] intValue];
      [self setData:[JSON objectForKey:@"item"]];

    }
    
    self.page++;
    
    [self.newsListTable reloadData];
    
                                         
  } failure:^(NSURLRequest *request, NSURLResponse *response, NSError *error, id jj)
  {
    NSLog(@"\nThe http request error:%@",error);
  }];
  
  [operation start];
  
}


- (void)setData:(NSDictionary *)data
{
  for (NSDictionary *dict in data) {
    newsObject *news = [[newsObject alloc] initWithDictionary:dict];
    [self.newsListArray addObject:news];
  }

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
  
  newsObject *news = [self.newsListArray objectAtIndex:row];
  
  cell.newsTitle.text = news.title;
  cell.newsPublishDate.text = news.addTime;
  
  if (news.thumb)
  {
    [cell.newsThumb setImageWithURL:[NSURL URLWithString:news.thumb] placeholderImage:[UIImage imageNamed:@"cell_photo_default_small.png"]];
  }
  
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80;
}

#pragma mark  - pullRefreshTable methods

/**
 *  @brief 刷新数据表
 *
 */
- (void)refreshTable
{
  [self getResult];
  self.newsListTable.pullTableIsRefreshing = NO;
  self.newsListTable.pullLastRefreshDate = [NSDate date];
}


/**
 *  @brief 载入更多
 *
 */
- (void)loadMoreToTable
{
  self.newsListTable.pullTableIsLoadingMore = NO;
}



#pragma mark - pullRefreshTable Delegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{

  [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
  [self performSelector:@selector(loadMoreToTable) withObject:nil afterDelay:1.0f];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
