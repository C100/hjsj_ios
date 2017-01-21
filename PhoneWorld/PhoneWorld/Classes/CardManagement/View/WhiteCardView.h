//
//  WhiteCardView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhiteCardTopView.h"
#import "WhiteCardFilterView.h"
#import "WhitePhoneModel.h"
#import "WhiteCardCell.h"

@interface WhiteCardView : UIScrollView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) void(^WhiteCardSelectCallBack)(NSString *numberpool,NSString *numberType);//筛选

@property (nonatomic) void(^ChangeCallBack)(id obj);//换一批

@property (nonatomic) void(^NextCallBack) (id obj);//下一步

@property (nonatomic) UIView *siftView;
@property (nonatomic) WhiteCardTopView *topView;
@property (nonatomic) WhiteCardFilterView *selectView;
@property (nonatomic) UICollectionView *contentView;

@property (nonatomic) NSArray<WhitePhoneModel *> *randomPhoneNumbers;//随即手机号
@property (nonatomic) WhiteCardCell *currentCell;

@end
