//
//  RepairCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RepairCardView.h"
#import "InputView.h"

@interface RepairCardView ()

@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) NSMutableArray *imageButtons;
@property (nonatomic) NSMutableArray *removeButtons;
@property (nonatomic) NSArray *choices;//邮寄选项
@property (nonatomic) NSArray *imageTitles;
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) UILabel *fastMailLB;
@property (nonatomic) UIView *imagesV;
@property (nonatomic) UIButton *currentImageButton;

@end

@implementation RepairCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(screenWidth, 650);
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = COLOR_BACKGROUND;
        self.inputViews = [NSMutableArray array];
        self.imageButtons = [NSMutableArray array];
        self.removeButtons = [NSMutableArray array];
        self.choices = @[@"顺丰到付",@"充值一百免邮费"];
        self.imageTitles = @[@"手持身份证正面照",@"身份证背面照"];
        self.leftTitles = @[@"补卡号码",@"补卡人姓名",@"证件号码",@"联系电话",@"邮寄地址",@"收件人姓名",@"收件人电话",@"邮寄选项"];
        
        for (int i = 0; i < self.leftTitles.count-1; i++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            [view addGestureRecognizer:tap];
            [self.inputViews addObject:view];
            [self addSubview:view];
        }
        
        [self emailChoiceView];
        [self addContent];
        [self nextButton];
    }
    return self;
}

- (UIView *)emailChoiceView{
    if (_emailChoiceView == nil) {
        _emailChoiceView = [[UIView alloc] init];
        [self addSubview:_emailChoiceView];
        [_emailChoiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(288);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(screenWidth);
        }];
        _emailChoiceView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseEmailAction)];
        [_emailChoiceView addGestureRecognizer:tap];
        
        UILabel *leftLB = [[UILabel alloc] init];
        [_emailChoiceView addSubview:leftLB];
        [leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        leftLB.textColor = [Utils colorRGB:@"#666666"];
        leftLB.font = [UIFont systemFontOfSize:14];
        leftLB.text = self.leftTitles.lastObject;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [_emailChoiceView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(16);
        }];
        imageView.image = [UIImage imageNamed:@"right"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        
        UILabel *rightLB = [[UILabel alloc] init];
        [_emailChoiceView addSubview:rightLB];
        [rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageView.mas_left).mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
        rightLB.textColor = [Utils colorRGB:@"#666666"];
        rightLB.font = [UIFont systemFontOfSize:12];
        rightLB.text = self.leftTitles.lastObject;
        self.fastMailLB = rightLB;
    }
    return _emailChoiceView;
}

- (void)addContent{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.emailChoiceView.mas_bottom).mas_equalTo(10);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(130);
    }];
    self.imagesV = v;
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"图片（点击图片可放大）";
    lb.textColor = [Utils colorRGB:@"#666666"];
    lb.font = [UIFont systemFontOfSize:14];
    NSRange range = [lb.text rangeOfString:@"（点击图片可放大）"];
    lb.attributedText = [Utils setTextColor:lb.text FontNumber:[UIFont systemFontOfSize:10] AndRange:range AndColor:[Utils colorRGB:@"#cccccc"]];
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(135);
        make.height.mas_equalTo(16);
    }];
    for (int i = 0; i < 2; i++) {
        UIButton *imageV = [[UIButton alloc] initWithFrame:CGRectMake(17 + 80*i, 40, 60, 60)];
        [v addSubview:imageV];
        imageV.layer.cornerRadius = 3;
        imageV.layer.masksToBounds = YES;
        imageV.layer.borderColor = [Utils colorRGB:@"#cccccc"].CGColor;
        imageV.layer.borderWidth = 1;
        [imageV setTitle:@"+" forState:UIControlStateNormal];
        [imageV setTitleColor:[Utils colorRGB:@"#cccccc"] forState:UIControlStateNormal];
        imageV.titleLabel.font = [UIFont systemFontOfSize:30];
        imageV.tag = 1000 + i;
        [imageV addTarget:self action:@selector(chooseImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.imageButtons addObject:imageV];
        
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
        [v addSubview:removeButton];
        [self.removeButtons addObject:removeButton];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15 + 80 *i, 104, 75, 10)];
        [v addSubview:lb];
        lb.text = self.imageTitles[i];
        lb.textColor = [Utils colorRGB:@"#cccccc"];
        lb.font = [UIFont systemFontOfSize:8];
    }
}

- (UIButton *)nextButton{
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imagesV.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
            make.bottom.mas_equalTo(-40);
        }];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setTitleColor:MainColor forState:UIControlStateNormal];
        _nextButton.layer.cornerRadius = 20;
        _nextButton.layer.borderColor = MainColor.CGColor;
        _nextButton.layer.borderWidth = 1;
        _nextButton.layer.masksToBounds = YES;
        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

#pragma mark - UIImagePickerViewController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.currentImageButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.currentImageButton setTitle:@"" forState:UIControlStateNormal];
    NSInteger i = self.currentImageButton.tag - 1000;
    UIButton *btn = self.removeButtons[i];
    btn.hidden = NO;
    UIViewController *viewController = [self viewController];
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Method

- (void)chooseImageAction:(UIButton *)button{
    self.currentImageButton = button;
    __block __weak RepairCardView *weakself = self;
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
    UIButton *btn = self.imageButtons[i];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:[Utils colorRGB:@"#cccccc"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    button.hidden = YES;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
//    for (InputView *iv in self.inputViews) {
//        iv.textField.hidden = YES;
//    }
    InputView *view = (InputView *)tap.view;
//    view.textField.hidden = NO;
    [view.textField becomeFirstResponder];
}

- (void)chooseEmailAction{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"邮寄选项" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.choices.firstObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.fastMailLB.text = self.choices.firstObject;
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:self.choices.lastObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.fastMailLB.text = self.choices.lastObject;
    }];
    [ac addAction:action1];
    [ac addAction:action2];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
}

- (void)buttonClickAction:(UIButton *)button{
    NSLog(@"--------------下一步");
}

@end
