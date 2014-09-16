//
//  newsObject.h
//  SinaNews
//
//  Created by coly on 13-7-18.
//  Copyright (c) 2013年 coly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsObject : NSObject

@property (assign, nonatomic) NSInteger id;//id，新闻的id看不到，每个新闻必须要有的
@property (strong, nonatomic) NSString *title;//标题
@property (strong, nonatomic) NSString *addTime;//发表时间
@property (strong, nonatomic) NSString *thumb;//缩略图地址

- (NewsObject *)initWithDictionary:(NSDictionary *)news;
@end
