//
//  colyAppDelegate.m
//  SinaNews
//
//  Created by coly on 13-6-14.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import "colyAppDelegate.h"
#import "NewsTableViewController.h"

@implementation colyAppDelegate
@synthesize mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  
//  [[CheckNetWork alloc] CheckNetworkStatus];
  
  //显示状态栏,上面的电池横条以及其他之类的（时间，运营商）
  [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
  
  //设置，初始化实例对象
  self.mainViewController = [[ColySidePanelController alloc] init];
#pragma mark 左边的控制器包含新闻类目控制器和列表控制器
  //引入新闻分类控制器，控制器进行左右的添加
  self.mainViewController.leftPanel = [[NewsCategoryViewController alloc] init];
    
  //初始化新闻列表table,什么国际，社会，评论之类的来着
  NewsTableViewController *table = [[NewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
  //设置默认分类，一开始就进去图片区域来处理
  table.typeName = defaultTypeName;
    
    
#pragma mark 中心新闻控制器的产生，就是具体的新闻列表，这个也有UITabView的这类的东西
  //初始化新闻控制器
  self.mainViewController.centerPanel = [[NewsViewController alloc] initWithRootViewController:table];
  
 
  self.window.rootViewController = self.mainViewController;
     
  [self.window makeKeyAndVisible];
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
