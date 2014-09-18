//
//  ColySidePanelController.m
//  SinaNews
//
//  Created by coly on 14-8-10.
//  Copyright (c) 2013年 coly. All rights reserved.
////左边视图控制器跟按钮的结合


#import "ColySidePanelController.h"

@interface ColySidePanelController ()

@end

@implementation ColySidePanelController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization,没看到区别啊
      self.shouldDelegateAutorotateToVisiblePanel = NO;
      
      //设置左边panel的width
      self.leftFixedWidth = leftChanelWidth;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重载掉系统默认的方法，去除阴影
- (void)styleContainer:(UIView *)container animate:(BOOL)animate duration:(NSTimeInterval)duration {
  
}
//重载掉系统默认的方法，去除圆角
- (void)stylePanel:(UIView *)panel {
  
}
#pragma mark 左边的按钮或者平板中心的按钮，按钮的定制
- (UIBarButtonItem *)leftButtonForCenterPanel {
  //显示左侧按钮（导航栏的左侧按钮）
  UIButton *showLeftChanelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  
  showLeftChanelBtn.frame = CGRectMake(0, 0, 44, 44);
  
  [showLeftChanelBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_left_menu_icon@2x.png"] forState:UIControlStateNormal];
  
  [showLeftChanelBtn addTarget:self action:@selector(toggleLeftPanel) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *navLeftBarItem = [[UIBarButtonItem alloc]initWithCustomView:showLeftChanelBtn];
  
  return navLeftBarItem;
}

/**
 *  @brief 显示左视图
 *
 */
- (void)toggleLeftPanel
{
  [self toggleLeftPanel:nil];
}

@end
