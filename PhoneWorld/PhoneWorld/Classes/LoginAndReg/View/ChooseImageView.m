//
//  ChooseImageView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/20.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "ChooseImageView.h"

@interface ChooseImageView ()

@property (nonatomic) UILabel *titleLB;
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray *imageTitles;
@property (nonatomic) UIButton *currentImageButton;

@end

@implementation ChooseImageView

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageTitles = @[@"手持身份证正面照",@"身份证背面照"];
        self.imageViews = [NSMutableArray array];
        self.imageButtons = [NSMutableArray array];
        self.removeButtons = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.title = title;
        [self titleLB];
        [self addContent];
    }
    return self;
}

- (UILabel *)titleLB{
    if (_titleLB == nil) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = self.title;
        _titleLB.textColor = [Utils colorRGB:@"#666666"];
        _titleLB.font = [UIFont systemFontOfSize:14];
        NSRange range = [_titleLB.text rangeOfString:@"（点击图片可放大）"];
        _titleLB.attributedText = [Utils setTextColor:_titleLB.text FontNumber:[UIFont systemFontOfSize:10] AndRange:range AndColor:[Utils colorRGB:@"#cccccc"]];
        [self addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(135);
            make.height.mas_equalTo(16);
        }];
    }
    return _titleLB;
}

- (void)addContent{
    for (int i = 0; i < 2; i++) {
        UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(17 + 80*i, 40, 60, 60)];
        [self addSubview:imageButton];
        imageButton.layer.cornerRadius = 3;
        imageButton.layer.masksToBounds = YES;
        imageButton.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        imageButton.layer.borderWidth = 1;
        [imageButton setTitle:@"+" forState:UIControlStateNormal];
        [imageButton setTitleColor:[Utils colorRGB:@"#cccccc"] forState:UIControlStateNormal];
        imageButton.titleLabel.font = [UIFont systemFontOfSize:30];
        imageButton.tag = 1000 + i;
        [imageButton addTarget:self action:@selector(chooseImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageButtons addObject:imageButton];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17 + 80*i, 40, 60, 60)];
        imageView.layer.cornerRadius = 3;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];
        imageView.hidden = YES;
        imageView.tag = i;
        [self.imageViews addObject:imageView];
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        
        UIButton *removeButton = [[UIButton alloc] initWithFrame:CGRectMake(69+80*i, 32, 16, 16)];
        removeButton.backgroundColor = [UIColor redColor];
        removeButton.layer.cornerRadius = 8;
        removeButton.layer.masksToBounds = YES;
        [removeButton setTitle:@"X" forState:UIControlStateNormal];
        [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        removeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        removeButton.hidden = YES;
        removeButton.tag = 1100+i;
        [removeButton addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:removeButton];
        [self.removeButtons addObject:removeButton];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15 + 80 *i, 104, 75, 10)];
        [self addSubview:lb];
        lb.text = self.imageTitles[i];
        lb.textColor = [Utils colorRGB:@"#cccccc"];
        lb.font = [UIFont systemFontOfSize:8];
    }
}

#pragma mark - UIImagePickerViewController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSInteger i = self.currentImageButton.tag - 1000;
    UIImageView *imageV = self.imageViews[i];
    imageV.hidden = NO;
    imageV.image = image;
    UIButton *addImageButton = self.imageButtons[i];
    addImageButton.userInteractionEnabled = NO;
    UIButton *removeButton = self.removeButtons[i];
    removeButton.hidden = NO;
    UIViewController *viewController = [self viewController];
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Method
- (void)chooseImageAction:(UIButton *)button{
    self.currentImageButton = button;
    __block __weak ChooseImageView *weakself = self;
    UIViewController *viewController = [self viewController];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = weakself;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker2 = [[UIImagePickerController alloc] init];
        imagePicker2.delegate = weakself;
        imagePicker2.allowsEditing = YES;
        imagePicker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [viewController presentViewController:imagePicker2 animated:YES completion:nil];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    [viewController presentViewController:ac animated:YES completion:nil];
}

- (void)removeAction:(UIButton *)button{
    NSInteger i = button.tag - 1100;
    UIImageView *imageV = self.imageViews[i];
    imageV.hidden = YES;
    button.hidden = YES;
    UIButton *addImageButton = self.imageButtons[i];
    addImageButton.userInteractionEnabled = YES;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImageView *imageV = (UIImageView *)tap.view;
    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:0 photoModelBlock:^NSArray *{
        //创建多大容量数组
        NSMutableArray *modelsM = [NSMutableArray array];
        PhotoModel *pbModel=[[PhotoModel alloc] init];
        pbModel.mid = 11;
        //设置查看大图的时候的图片
        pbModel.image = imageV.image;
        pbModel.sourceImageView = imageV;//点击返回时图片做动画用
        [modelsM addObject:pbModel];
        return modelsM;
    }];
}

@end
