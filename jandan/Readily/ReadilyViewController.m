//
//  ReadilyViewController.m
//  jandan
//
//  Created by 代烁 on 2020/6/26.
//  Copyright © 2020 代烁. All rights reserved.
//

#import "ReadilyViewController.h"
#import <Masonry.h>
#import "BoringPictureBean.h"
#import "CellBoringPicture.h"
#import "ReadilyListLoader.h"
@interface ReadilyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong,readwrite) UITableView *tableView;
@property(nonatomic,strong,readwrite) NSArray<BoringPictureBean *> *dataArray;
@property(nonatomic,strong,readwrite) ReadilyListLoader *listLoader;
@property(nonatomic,strong,readwrite) UIActivityIndicatorView * loadingView;
@end

@implementation ReadilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    _loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _loadingView.color = [UIColor redColor];
    [self.view addSubview:_loadingView];
    [_loadingView startAnimating];
    
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        
    }];
    
    
    _listLoader = [[ReadilyListLoader alloc]init];
    
    __weak typeof (self) wself = self;
    
    [self.listLoader loadReadilyListWithFinishBlock:^(BOOL success, NSArray<BoringPictureBean *> * _Nullable dataArray) {
        
        __strong typeof (wself) strongSelf = wself;
        if(success){
            
            strongSelf.dataArray = dataArray;
            [strongSelf.tableView reloadData];
            
        }
        
        
        
    }];
    
  
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [[[_dataArray objectAtIndex:indexPath.row].pictureModels firstObject].height intValue];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellBoringPicture *cell = [tableView dequeueReusableCellWithIdentifier:@"readily_cell"];
    if(!cell){
        cell = [[CellBoringPicture alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"readily_cell"];
    }
    [cell setData:  [_dataArray objectAtIndex:indexPath.row]];
    return cell;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden =NO;
}


@end
