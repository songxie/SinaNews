//
//  NewsDetailViewController.m
//  SinaNews
//
//  Created by coly on 14-8-7.
//  Copyright (c) 2013年 coly. All rights reserved.
//添加了一个网页视图，webView更多的是添加一个网页视图

#import "NewsDetailViewController.h"
#import "NewsDetailWebView.h"
#import "Tools.h"

@interface NewsDetailViewController ()< UIWebViewDelegate>

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIActivityIndicatorView *activeView;
@end

@implementation NewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization 意思是定制初始化；
      self.navigationItem.titleView=[Tools getTtileViewWithTitle:@"新闻详细" andPositionOffset:110.f];
      
      //开始自定义返回按钮，自定义返回按钮，采用导航栏的左边按钮，添加一个定制的CustomView,在上面 - (id)initWithCustomView:(UIView *)customView;第一次遇见
        [self addCustomButton];
     
    }
    return self;
}
- (void)addCustomButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(0, 0, 44, 44);
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_left_picture_back_icon@2x.png"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navLeftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = navLeftBarItem;

}
- (void)back
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadWebViewFromNewsId:(int)id andSetViewTitle:(NSString *)title
{
  //  self.title = title;
  NSString *detailURL = [NSString stringWithString:newDetailURL(id)];
  NewsDetailWebView *detaiView = [[NewsDetailWebView alloc] initWithFrame:self.view.bounds];//屏幕的尺寸大小
  
  //设置这个很重要，不然uiwebview没法接收
  [detaiView setDelegate:self];
  [detaiView loadHTMLFromString:detailURL];
  [self.view addSubview:detaiView];//(有一个层次的问题，默认是要使用的那个先进行添加)
}

//当网页正在加载时，显示正在载入
- (void)webViewDidStartLoad:(UIWebView *)webView
{
  debugLog(@"\nwebview start loading");
    //添加一个view
    [self addView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  debugLog(@"\nwebview finish loading");
 //  [webView stringByEvaluatingJavaScriptFromString:@"loadImgs();"];
    [self over];
  
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  debugLog(@"didFailLoadWithError:%@", error);
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
- (void)addView
{
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(-20, -30, 340, 510)];
    [self.loadingView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loadingView];
    
    UILabel *loadingText = [UILabel new];
    loadingText.text = @"载入中...";
    loadingText.frame = CGRectMake((kDeviceWidth-80)/2 + 48, (kDeviceHeight -30)/2-15, 80, 30);
    [loadingText setBackgroundColor:[UIColor clearColor]];
    [self.loadingView addSubview:loadingText];
    //添加菊花
    self.activeView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    [self.activeView setCenter:self.loadingView.center];
    [self.activeView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.loadingView addSubview:self.activeView];
    
    
    [self.activeView startAnimating];

}

- (void)over
{
    [self.activeView stopAnimating];
    [self.loadingView removeFromSuperview];
    

}
@end
