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
  
  //显示状态栏
  [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
  
  //设置
  self.mainViewController = [[ColySidePanelController alloc] init];
  
  //引入新闻分类控制器
  self.mainViewController.leftPanel = [[NewsCategoryViewController alloc] init];
  
  
  //初始化新闻列表table
  NewsTableViewController *table = [[NewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
  
  //设置默认分类
  table.typeName = defaultTypeName;
  
  //初始化新闻控制器
  self.mainViewController.centerPanel = [[NewsViewController alloc] initWithRootViewController:table];
  
 //表视图为新闻内容或者类表使用，新闻控制类的情况暂时不明朗
  self.window.rootViewController = self.mainViewController;
 
#pragma mark 开始进行修改了
    
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
