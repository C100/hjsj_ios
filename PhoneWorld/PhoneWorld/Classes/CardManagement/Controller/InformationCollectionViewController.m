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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"读取信息" style:UIBarButtonItemStylePlain target:self action:@selector(readInfoAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    self.navigationItem.backBarButtonItem = [Utils returnBackButton];
    
    self.informationCollectionView = [[InformationCollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andUserinfos:self.userinfosDic];
    [self.view addSubview:self.informationCollectionView];
}

- (void)readInfoAction{
    
}

@end
