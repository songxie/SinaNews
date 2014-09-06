//
//  NewsCategoryViewController.m
//  SinaNews
//
//  Created by coly on 13-8-6.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import "NewsCategoryViewController.h"
#import "NewsCategoryCell.h"
#import "NewsCategoryObject.h"
#import "ColySidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "NewsViewController.h"
#import "NewsTableViewController.h"
#pragma mark 委托可以写到这里来着
@interface NewsCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) UITableView *categoryTable;

@end

@implementation NewsCategoryViewController
@synthesize categoryArray,categoryTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
        //数据的准备以及控制器的添加
      self.categoryArray = [[NSMutableArray alloc] init];
      
      //开始初始化分类,分类的名字
      NSArray *catNameArray = [[NSArray alloc] initWithObjects:@"国内",@"国际",@"图片",@"社会",@"探索",@"军事",@"评论",nil];
        
      NSArray *catThumbArray = [[NSArray alloc] initWithObjects:@"toutiao@2x.png",@"yule@2x",@"tupian@2x",@"boke@2x",@"keji@2x",@"caijing@2x",@"tiyu@2x",nil];
      
      for (int i = 0;i<[catNameArray count];i++)
      {
#warning 这个还不是很清楚的说,开始使用模型了处理了
          //将名字和图片写在一个字典当中来实现,字典可以存放键值队，字典被一个对象给带走了,自己实例化的对象
        NSDictionary *catDic = [NSDictionary dictionaryWithObjectsAndKeys:[catNameArray objectAtIndex:i],@"title",[catThumbArray objectAtIndex:i],@"thumb",nil];
        //直接进行调用，并且直接进行赋值
        NewsCategoryObject *catObject = [[NewsCategoryObject alloc]initWithDictionary:catDic];
#warning 关键的一步来处理，顺道进行赋值，对象累加命名可以重复的使用着
          NSLog(@"%@%@",catObject.thumb,catObject.title);
        [self.categoryArray addObject:catObject];
      //相当于内存的释放，创建成字典，接着创建对象包含一个字典
        catDic = nil;catObject = nil;
      }
      self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftchannel_bg@2x"]];
    
      
      //顶部背景
      UIImage *headImage = [UIImage imageNamed:@"leftchannel_head_bg@2x"];
      UIImageView *headImageView = [[UIImageView alloc] initWithImage:headImage];
      headImageView.frame = CGRectMake(0, 0, kDeviceWidth, 46);
      [self.view addSubview:headImageView];
      
      //顶部“新浪新闻”文字
      UILabel *sinaText = [UILabel new];
      sinaText.frame = CGRectMake(10, 8, 80, 30);
      sinaText.text = @"新浪新闻";
      sinaText.textColor = [UIColor whiteColor];
      sinaText.backgroundColor = [UIColor clearColor];/*透明的这个属性非常的重要的说*/
      sinaText.font = [UIFont fontWithName:@"Helvetica" size:18];
      [self.view addSubview:sinaText];
      
      //订阅，就是那个黄色的按钮
      UIButton *rssButton = [UIButton buttonWithType:UIButtonTypeCustom];
      rssButton.frame = CGRectMake(180, 13, 20, 20);
      [rssButton setBackgroundImage:[UIImage imageNamed:@"leftchannel_head_plus@2x"] forState:UIControlStateNormal];
      [self.view addSubview:rssButton];
      
      //新闻分类的tableview
      self.categoryTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 56, leftChanelWidth, kDeviceHeight) style:UITableViewStylePlain];
      self.categoryTable.backgroundColor = [UIColor clearColor];
      self.categoryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
      self.categoryTable.delegate = self;
      self.categoryTable.dataSource = self;
      [self.view addSubview:self.categoryTable];
      
      
      
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",self.categoryArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.categoryArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return newsCategoryCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *newsCategoryIdenfifier = @"newsCategory";
  NewsCategoryCell *cell = [self.categoryTable dequeueReusableCellWithIdentifier:newsCategoryIdenfifier];
  if (cell == nil)
  {
    cell = [[NewsCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsCategoryIdenfifier];
  }
  
  //设置cell数据
  NSInteger row = [indexPath row];
  //数据进行调用的情况
  NewsCategoryObject *cat = [self.categoryArray objectAtIndex:row];
  cell.categoryName.text = cat.title;
  cell.categoryThumb.image = [UIImage imageNamed:cat.thumb];
  
  if ([cat.title isEqual: defaultTypeName])
  {
    //设置默认选中
    [self.categoryTable selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  NSInteger row = [indexPath row];
  NewsCategoryObject *cat = [self.categoryArray objectAtIndex:row];
  
  NewsTableViewController *table = [[NewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
  
  //设置默认分类
  table.typeName = cat.title;
#pragma mark 这句话非常的重要，可以说是视图切换的关键之处，这个类继承的是UIViewController,为什么会
  self.sidePanelController.centerPanel = [[NewsViewController alloc] initWithRootViewController:table];      //这个是当做导航栏用的，并且伴随着一个表视图
//    //初始化新闻控制器
//    self.mainViewController.centerPanel = [[NewsViewController alloc] initWithRootViewController:table];
  
}





@end
