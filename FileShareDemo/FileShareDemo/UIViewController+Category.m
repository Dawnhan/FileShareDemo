//
//  UIViewController+Category.m
//  FileShareDemo
//
//  Created by 郑晗 on 2019/4/2.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "UIViewController+Category.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey                     = &HttpRequestHUDKey;
static const void *ReturnRightItemClickBlockKey          = &ReturnRightItemClickBlockKey;

typedef void(^ReturnRightItemClickBlock)(void);

@interface UIViewController()

@property (nonatomic ,copy)ReturnRightItemClickBlock rightItemClickBlock;

@end

@implementation UIViewController (Category)

- (void)setupRightNavItemWithTitle:(NSString *)title action:(void (^)(void))rightItemClickAction{
    if (self.navigationController) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(0, 0, 80, 44);
        [button addTarget:self action:@selector(rightItemClickAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        self.rightItemClickBlock = rightItemClickAction;
    }
}
- (void)rightItemClickAction
{
    if (self.rightItemClickBlock) {
        self.rightItemClickBlock();
    }
}
#pragma mark -------------------setKey-------------------

- (ReturnRightItemClickBlock)rightItemClickBlock {
    return objc_getAssociatedObject(self, ReturnRightItemClickBlockKey);
}
- (void)setRightItemClickBlock:(ReturnRightItemClickBlock)rightItemClickBlock
{
    objc_setAssociatedObject(self, ReturnRightItemClickBlockKey, rightItemClickBlock, OBJC_ASSOCIATION_COPY);
}
@end
