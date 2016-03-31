//
//  HistoryModel.m
//  loadWeb
//
//  Created by 申帅 on 16/3/23.
//  Copyright © 2016年 申帅. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel{
    NSMutableDictionary *webDictionary;
    NSMutableArray *webName;
}

- (instancetype)init{
    if (self = [super init]) {
        webDictionary = [NSMutableDictionary dictionary];
        webName = [NSMutableArray array];
    }
    return self;
}

+ (id)manager{
    static HistoryModel *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HistoryModel alloc] init];
    });
    return manager;
}

- (void)saveWebController:(UIViewController *)webController webURl:(NSString *)webURl webTitle:(NSString *)webTitle{
    
    [webDictionary setObject:webController forKey:webTitle];
    if ([webName containsObject:webTitle]) {
        return;
    }
    [webName addObject:webTitle];
    
}

- (UIViewController *)getWebControllerWithwebTitle:(NSString *)webTitle{
    return [webDictionary valueForKey:webTitle];
}

- (NSMutableArray *)fillAllWebTitle{
    return webName;
}

- (NSInteger)findAllWebCount{
    return webName.count;
}
@end
