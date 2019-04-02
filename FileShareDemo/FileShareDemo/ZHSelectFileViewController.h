//
//  ZHSelectFileViewController.h
//  FileShareDemo
//
//  Created by 郑晗 on 2019/4/2.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHSelectFileViewController : UIViewController

@property (nonatomic,copy)void (^selectFile)(NSString *filePath);

@end

NS_ASSUME_NONNULL_END
