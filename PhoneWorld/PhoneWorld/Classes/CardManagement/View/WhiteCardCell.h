//
//  WhiteCardCell.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/19.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhitePhoneModel.h"

@interface WhiteCardCell : UICollectionViewCell

@property (nonatomic) UIButton *leftButton;

@property (nonatomic) UIButton *rightButton;

@property (nonatomic) UILabel *phoneLB;

@property (nonatomic) WhitePhoneModel *whitePhoneModel;

@end
