//
//  CXTableViewController.m
//  CXControl
//
//  Created by xiaoma on 17/3/20.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXTableViewController.h"
#import "CXTableViewCell.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface CXTableViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *tableView;//列表

@property (strong, nonatomic) NSMutableArray *dataArray;//数据源

@property (strong, nonatomic) NSMutableArray *deleteArray;//存储删除的数据

@property (strong, nonatomic) UIBarButtonItem *editItem;//编辑，删除按钮

@property (strong, nonatomic) UIBarButtonItem *selectItem;//全选，全不选按钮

@end

@implementation CXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"OC-CXTableView";
    
    [self createUI];
    
    [self createDataArray];
    
    [self createTableView];
    
    [self.tableView registerClass:[CXTableViewCell class] forCellReuseIdentifier:@"CellID"];
}

#pragma mark - UITableViewDataSource/delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

//左滑cell时出现的按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除数据源
        [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        
        //或者删除cell
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    deleteAction.backgroundColor = [UIColor colorWithRed:246 green:246 blue:246 alpha:1];
    editAction.backgroundColor = [UIColor colorWithRed:246 green:246 blue:246 alpha:1];
    
    return @[deleteAction, editAction];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.deleteArray addObject:_dataArray[indexPath.row]];
}

//取消选中cell
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.deleteArray removeObject:_dataArray[indexPath.row]];
}

#pragma mark - createUI
- (void)createUI {
    _editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemAction:)];
    
    _selectItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectItemAction:)];
    
    self.navigationItem.rightBarButtonItems = @[_editItem];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];

}

- (void)createDataArray {
    _dataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 40; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"这是是第%d行数据",i]];
    }
}

#pragma mark - other action
//编辑按钮
- (void)editItemAction:(UIBarButtonItem *)ietm {
    //点击编辑按钮
    static BOOL flag = NO;
    flag = !flag;
    
    if (flag) {
        //编辑模式的时候可以多选
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        
        self.tableView.editing = YES;
        
        _editItem.title = @"删除";
        
        self.navigationItem.rightBarButtonItems = @[_editItem,_selectItem];
    } else {
        self.tableView.editing = NO;
        
        _editItem.title = @"编辑";
        
        self.navigationItem.rightBarButtonItems = @[_editItem];
        
        [_dataArray removeObjectsInArray:_deleteArray];
        
        [_deleteArray removeAllObjects];
        
        [_tableView reloadData];
    }
}

//全选按钮
- (void)selectItemAction:(UIBarButtonItem *)item {
    static BOOL flag = NO;
    flag = !flag;
    
    if (flag) {
        _selectItem.title = @"全不选";
        
        //获得选中的所有行
        for (int i = 0; i < _dataArray.count; i++) {
            NSIndexPath *indexPatch = [NSIndexPath indexPathForItem:i inSection:0];
            
            [self.tableView selectRowAtIndexPath:indexPatch animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        
        [self.deleteArray addObjectsFromArray:_dataArray];
    } else {
        _selectItem.title = @"全选";
        
        [self.tableView selectRowAtIndexPath:0 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [_deleteArray removeAllObjects];
    }
    
    self.navigationItem.rightBarButtonItems = @[_editItem,_selectItem];
}


#pragma mark - lazy
- (NSMutableArray *)deleteArray {
    if (_deleteArray == nil) {
        _deleteArray = [[NSMutableArray alloc] init];
    }
    
    return _deleteArray;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;  {
    if (scrollView == _tableView) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:5 inSection:1];
        CGRect rectInTableView = [_tableView rectForRowAtIndexPath:tempIndexPath];
        CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
        NSLog(@"================%f",rect.origin.y);
        
        if (rect.origin.y < -86 ) {
            [_tableView scrollToRowAtIndexPath:tempIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    
//    CGRect rectInTableView = [scrollView rectForRowAtIndexPath:indexPath];
    
}

@end
