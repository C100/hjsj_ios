//
//  ChoosePackageTableView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChoosePackageTableView.h"
#import "ChoosePackageDetailViewController.h"
#import "ChoosePackageDetailView.h"

@interface ChoosePackageTableView ()<ChoosePackageDetailViewDelegate>

@property (nonatomic) NSArray *titles;
@property (nonatomic) int currentIndex;

@end

@implementation ChoosePackageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.packagesDic = [NSArray array];
        self.currentDic = [NSDictionary dictionary];
        self.titles = @[@"套餐选择",@"活动包选择",@"预存金额"];
        [self registerClass:[NormalTableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        self.bounces = NO;
    }
    return self;
}

- (void)setDetailModel:(PhoneDetailModel *)detailModel{
    _detailModel = detailModel;
    self.inputView.textField.text = detailModel.prestore;
}

- (void)setImsiModel:(IMSIModel *)imsiModel{
    _imsiModel = imsiModel;
    self.inputView.textField.text = [NSString stringWithFormat:@"%d元",imsiModel.prestore];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        self.inputView = [[InputView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        self.inputView.textField.userInteractionEnabled = NO;
        self.inputView.textField.placeholder = @"请输入预存金额";
        self.inputView.leftLabel.font = [UIFont systemFontOfSize:textfont16];
        self.inputView.textField.font = [UIFont systemFontOfSize:textfont16];
        if (self.detailModel) {
            self.inputView.textField.text = self.detailModel.prestore;
        }else if(self.imsiModel){
            self.inputView.textField.text = [NSString stringWithFormat:@"%d",self.imsiModel.prestore];
        }
        self.inputView.leftLabel.text = @"预存金额";
        self.inputView.textField.userInteractionEnabled = NO;

        [cell.contentView addSubview:self.inputView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        CGSize titleSize = [Utils sizeWithFont:[UIFont systemFontOfSize:textfont16] andMaxSize:CGSizeMake(0, 20) andStr:self.titles[indexPath.row]];
        cell.titleLabel.text = self.titles[indexPath.row];
        [cell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(titleSize.width+1.0);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
        }];
        cell.detailLabel.text = @"请选择";
        [cell.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(cell.rightImageView.mas_left).mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(cell.titleLabel.mas_right).mas_equalTo(10);
        }];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     套餐选择
     活动包选择
     */
    
    self.currentIndex = (int)indexPath.row;
    
    NormalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.currentCell = cell;
    
    UIViewController *viewController = [self viewController];

    switch (indexPath.row) {
        case 0:
        {
            ChoosePackageDetailViewController *vc = [[ChoosePackageDetailViewController alloc] init];
            vc.title = @"套餐选择";
            vc.packagesDic = self.packagesDic;//所有套餐
            vc.packageTableView = self;
            [viewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//            cell.userInteractionEnabled = NO;
            
            if (!self.currentDic[@"id"]) {
                [Utils toastview:@"套餐未选择"];
            }else{
//                __block __weak ChoosePackageTableView *weakself = self;
//                
//                if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
//                    cell.userInteractionEnabled = YES;
//                }
                
                
                ChoosePackageDetailViewController *vc = [[ChoosePackageDetailViewController alloc] init];
                vc.title = @"活动包选择";
                vc.packageTableView = self;
//                vc.packagesDic = promotionsArray;//所有活动包
                vc.currentID = self.currentDic[@"id"];//当前选中套餐ID
                [viewController.navigationController pushViewController:vc animated:YES];


//                [WebUtils requestPackagesWithID:self.currentDic[@"id"] andCallBack:^(id obj) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                       cell.userInteractionEnabled = YES;
//                    });
//                    if (obj) {
//                        NSString *code = [NSString stringWithFormat:@"%@",obj[@"code"]];
//                        if ([code isEqualToString:@"10000"]) {
//                            
//                            NSArray *promotionsArray = obj[@"data"][@"promotions"];
//                            
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                ChoosePackageDetailViewController *vc = [[ChoosePackageDetailViewController alloc] init];
//                                vc.title = @"活动包选择";
//                                vc.packageTableView = self;
//                                vc.packagesDic = promotionsArray;//所有活动包
//                                vc.currentID = weakself.currentDic[@"id"];//当前选中套餐ID
//                                [viewController.navigationController pushViewController:vc animated:YES];
//                            });
//                            
//                            
//                        }else{
//                            NSString *mes = [NSString stringWithFormat:@"%@",obj[@"mes"]];
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [Utils toastview:mes];
//                            });
//                        }
//                    }
//                }];
            }
        }
            break;
    }
}

#pragma mark - Method
- (void)getPackage:(NSDictionary *)package{
    self.currentCell.detailLabel.text = package[@"name"];
    
    if (self.currentIndex == 0) {//套餐
        self.currentDic = package;
    }else if(self.currentIndex == 1){//活动包
        self.currentPromotionDic = package;
    }
}


@end
