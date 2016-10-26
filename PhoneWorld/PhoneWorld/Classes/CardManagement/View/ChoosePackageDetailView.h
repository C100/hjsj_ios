//
//  ChoosePackageDetailView.h
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/26.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoosePackageDetailViewDelegate <NSObject>

- (void)getPackage:(NSString *)package;

@end

@interface ChoosePackageDetailView : UIView

@property (nonatomic) id<ChoosePackageDetailViewDelegate> delegate;

@property (nonatomic) UIButton *currentButton;

@end
