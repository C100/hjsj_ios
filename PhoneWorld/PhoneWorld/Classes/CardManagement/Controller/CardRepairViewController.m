//
//  CardRepairViewController.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "CardRepairViewController.h"
#import "RepairCardView.h"

@interface CardRepairViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic) RepairCardView *repairCardView;
@end

@implementation CardRepairViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.repairCardView = [[RepairCardView alloc] init];
    [self.view addSubview:self.repairCardView];
    [self.repairCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    __weak __block CardRepairViewController *weakself = self;
    [self.repairCardView setRepairCardCallBack:^(NSInteger tag) {
        //1000 1001  身份证前后
        if (tag == 1000 || tag == 1001) {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = weakself;
                imagePicker.editing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [weakself presentViewController:imagePicker animated:YES completion:nil];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = weakself;
                imagePicker.editing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [weakself presentViewController:imagePicker animated:YES completion:nil];
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:action1];
            [ac addAction:action2];
            [ac addAction:action3];
            [weakself presentViewController:ac animated:YES completion:nil];
        }
        //1050  下一步按钮
        if (tag == 1050) {
            
        }
    }];
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"-=-=-=-=-=-=-=-=-=-=-%@",info);
//    UIImage *image = [];
}
@end
