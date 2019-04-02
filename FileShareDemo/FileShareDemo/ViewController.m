//
//  ViewController.m
//  FileShareDemo
//
//  Created by 郑晗 on 2019/4/2.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "ViewController.h"
#import "ZHSelectFileViewController.h"
@interface ViewController ()

- (IBAction)selectFileAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (IBAction)selectFileAction:(UIButton *)sender {
    ZHSelectFileViewController *vc = [[ZHSelectFileViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
