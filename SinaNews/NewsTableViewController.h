//
//  NewsTableViewController.h
//  SinaNews
//
//  Created by coly on 14-6-17.
//  Copyright (c) 2013年 coly. All rights reserved.
//具体新闻的表视图，这个是采用上下来刷新来实现的

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface NewsTableViewController : UITableViewController

//新闻列表table，这个类继承UITabView，采用第三方类库来进行书写的，值得看研究一下
@property (retain, nonatomic) PullTableView *newsListTable;

//保存新闻实体类的数组
@property (strong, nonatomic) NSMutableArray *newsListArray;

//分类名称,显示在导航栏的上面,明确我们点击进去是什么名字
@property (strong, nonatomic) NSString *typeName;


@end
