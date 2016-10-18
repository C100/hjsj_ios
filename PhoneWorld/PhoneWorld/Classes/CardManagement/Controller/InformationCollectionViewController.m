//
//  InformationCollectionViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InformationCollectionViewController.h"
#import "InformationCollectionView.h"

@interface InformationCollectionViewController ()
@property (nonatomic) InformationCollectionView *informationCollectionView;
@end

@implementation InformationCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息采集";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"读取信息" style:UIBarButtonItemStylePlain target:self action:@selector(readInfoAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    self.informationCollectionView = [[InformationCollectionView alloc] init];
    [self.view addSubview:self.informationCollectionView];
    [self.informationCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)readInfoAction{
    
}

@end
