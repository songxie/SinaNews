//
//  newsDetailWebView.m
//  SinaNews
//
//  Created by coly on 13-7-19.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import "NewsDetailWebView.h"

@implementation NewsDetailWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        /*scalesPageToFit属性
         
         默认情况下UIWebView加载HTML页面后，会以页面的原始大小进行显示，亦即如果页面的大小超出UIWebView视口大小，UIWebView会出现滚动效果，而且用户只能通过滚动页面来查看不同区域的内容，不能使用手指的捏合手势来放大或缩小页面。通过设置
         
         webView.scalesPageToFit = YES ;
         UIWebView可以缩放HTML页面来适配其视口大小，从而达到整屏显示内容的效果，并且用户可以用捏合动作来放大或缩小页面来查看内容。*/
      self.scalesPageToFit = YES;
      
    }
    return self;
}

- (void)loadHTMLFromString:(NSString *)stringURL
{
//  [self loadDocument:@"test.css"];
  NSURL *url = [NSURL URLWithString:stringURL];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [self loadRequest:request];//加载这个请求，得到需要的东西
}




@end
