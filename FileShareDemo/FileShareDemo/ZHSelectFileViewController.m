//
//  ZHSelectFileViewController.m
//  FileShareDemo
//
//  Created by 郑晗 on 2019/4/2.
//  Copyright © 2019年 郑晗. All rights reserved.
//

#import "ZHSelectFileViewController.h"
#import "UIViewController+Category.h"
#import <Quicklook/Quicklook.h>

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高度

@interface ZHSelectFileViewController ()<UITableViewDelegate,UITableViewDataSource,QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property(nonatomic,strong)  UITableView  *tableView;

@property(nonatomic,strong)  NSMutableArray  *dataSource;

@property(nonatomic,copy)  NSString  *filePath;

@end

@implementation ZHSelectFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择文件";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self loadLocalData];
    
    __weak typeof(self) weakSelf = self;
    [self setupRightNavItemWithTitle:@"刷新" action:^{
        [weakSelf loadLocalData];
    }];
}

/**
 显示本地文件列表
 */
- (void)loadLocalData
{
    NSArray *inboxArray = [self getFilePathArray:@"Inbox"];
    if (inboxArray.count) {
        self.dataSource = (NSMutableArray *)[[inboxArray reverseObjectEnumerator] allObjects];
    }
    [self.tableView reloadData];
}

/**
 获取本地文件相对路径

 @param path Document下的目标路径
 @return 返回数据
 */
- (NSArray *)getFilePathArray:(NSString *)path
{
    NSString *documentPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *thePath = [documentPath stringByAppendingFormat:@"/%@",path];
    NSFileManager *myFileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [myFileManager enumeratorAtPath:thePath];
    
    BOOL isDir = NO;
    BOOL isExist = NO;
    
    //列举目录内容，可以遍历子目录
    NSMutableArray *muArr = [[NSMutableArray alloc]init];
    for (NSString *path in myDirectoryEnumerator.allObjects) {
        
        NSLog(@"%@", path);  // 所有路径
        
        isExist = [myFileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", thePath, path] isDirectory:&isDir];
        if (isDir) {
            NSLog(@"%@", path);    // 目录路径
        } else {
            NSLog(@"%@", path);    // 文件路径
            [muArr addObject:path];
        }
    }
    return muArr.copy;
}

#pragma mark UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.filePath = self.dataSource[indexPath.row];
    QLPreviewController *previewController =[[QLPreviewController alloc]init];
    previewController.delegate=self;
    previewController.dataSource=self;
    [previewController setCurrentPreviewItemIndex:indexPath.row];
    [self presentViewController:previewController animated:YES completion:nil];
}

#pragma mark QLPreviewControllerDataSource && QLPreviewControllerDelegate

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController*)previewController {
    return 1;
}

- (id)previewController:(QLPreviewController*)previewController previewItemAtIndex:(NSInteger)idx {
    NSString *documentPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *inboxPath = [documentPath stringByAppendingString:@"/Inbox"];
    NSString *filePath = [inboxPath stringByAppendingFormat:@"/%@",self.filePath];
    return [NSURL fileURLWithPath:filePath];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
