//
//  UIViewController+Category.h
//  FileShareDemo
//
//  Created by 郑晗 on 2019/4/2.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Category)

- (void)setupRightNavItemWithTitle:(NSString *)title action:(void (^)(void))rightItemClickAction;

@end

NS_ASSUME_NONNULL_END
