//
//  NewsViewController.m
//  SinaNews
//
//  Created by coly on 14-6-17.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import "NewsViewController.h"
#import "ColySidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "Tools.h"

@implementation NewsViewController

//新闻视图控制器
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//该视图控制器用于导航栏的背景颜色，这个是定义的宏
  self.view.backgroundColor = cccColor;//视图的背景颜色
  
  UIImage *naviBarBackground = [UIImage imageNamed:@"toolbar_bg@2x"];
//加号的类方法，调用需要类去调用，创建制定长度和宽度的图片
#pragma mark MVC模式一：01我只知道控制器上面有图片，具体这张图片的大小和颜色我不需要管它,让其他的来做
  UIImage *navSizeImage = [Tools compressImage:naviBarBackground bySpecifiedWidth:kDeviceWidth andHeight:44 andColor:nil];
//default是竖版的nav bar，landscapePhone是横版的nav bar，长度不一样
  [self.navigationBar setBackgroundImage:navSizeImage forBarMetrics:UIBarMetricsDefault];
//typedef NS_ENUM(NSInteger, UIBarMetrics) {
//    UIBarMetricsDefault,
//    UIBarMetricsLandscapePhone,
//};

  
}



- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
