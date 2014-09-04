//
//  NewsViewController.m
//  SinaNews
//
//  Created by coly on 13-6-17.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import "NewsViewController.h"
#import "ColySidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "Tools.h"

@implementation NewsViewController


- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//该视图控制器用于导航栏的背景颜色，这个是定义的宏
  self.view.backgroundColor = cccColor;
  
  UIImage *naviBarBackground = [UIImage imageNamed:@"toolbar_bg@2x"];
//加号的类方法，调用需要类去调用，创建制定长度和宽度的图片
  UIImage *navSizeImage = [Tools compressImage:naviBarBackground bySpecifiedWidth:kDeviceWidth andHeight:44 andColor:nil];
//default是竖版的nav bar，landscapePhone是横版的nav bar，长度不一样
  [self.navigationBar setBackgroundImage:navSizeImage forBarMetrics:UIBarMetricsDefault];
  
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
