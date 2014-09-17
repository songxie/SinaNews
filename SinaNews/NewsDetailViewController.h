//
//  NewsDetailViewController.h
//  SinaNews
//
//  Created by coly on 14-8-7.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController
//每次进行传值（id title),写一个方法就可以避免一直传值的过程了
- (void)loadWebViewFromNewsId:(int)id andSetViewTitle:(NSString *)title;
@end
