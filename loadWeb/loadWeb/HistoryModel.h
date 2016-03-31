//
//  HistoryModel.h
//  loadWeb
//
//  Created by 申帅 on 16/3/23.
//  Copyright © 2016年 申帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
/**
 *  单利
 *
 *  @return
 */
+ (id)manager;

- (void)saveWebController:(UIViewController *)webController
                 webURl:(NSString *)webURl
                 webTitle:(NSString *)webTitle;

- (UIViewController *)getWebControllerWithwebTitle:(NSString *)webTitle;

- (NSInteger)findAllWebCount;

- (NSMutableArray *)fillAllWebTitle;

@end
