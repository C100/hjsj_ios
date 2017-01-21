//
//  NaviViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/15.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "NaviViewController.h"

@interface NaviViewController ()

@end

@implementation NaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationBar.tintColor = [Utils colorRGB:@"#999999"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:MainColor};
    self.navigationBar.translucent = NO;
    UIImageView *lineImageView = [Utils findHairlineImageViewUnder:self.navigationBar];
    lineImageView.hidden = YES;
}

@end
