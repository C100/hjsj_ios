//
//  TransferCardView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/13.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "TransferCardView.h"
#import "InputView.h"

#define imageW (screenWidth - 40)/2
#define hw 100/167.0

@interface TransferCardView ()
//@property (nonatomic) NSArray *warnings;
@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSMutableArray *inputViews;
@property (nonatomic) NSMutableArray *imageButtons;
@property (nonatomic) NSMutableArray *removeButtons;
@property (nonatomic) UIButton *currentImageButton;
@property (nonatomic) NSArray *imageTitles;
@property (nonatomic) UIView *lastView;
@end

@implementation TransferCardView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"过户号码",@"姓名",@"证件号码",@"联系电话",@"地址"];
        self.inputViews = [NSMutableArray array];
        self.imageButtons = [NSMutableArray array];
        self.removeButtons = [NSMutableArray array];
        self.imageTitles = @[@"手持身份证正面照",@"身份证背面照"];

        self.contentSize = CGSizeMake(screenWidth, 600);
        
        self.bounces = NO;
        for (int i = 0; i < self.leftTitles.count; i++) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            InputView *view = [[InputView alloc] initWithFrame:CGRectMake(0, 1 + 41*i, screenWidth, 40)];
            [self addSubview:view];
            view.leftLabel.text = self.leftTitles[i];
            view.textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.leftTitles[i]];
            [view addGestureRecognizer:tap];
            [self.inputViews addObject:view];
            [self addSubview:view];
        }
        [self addContentWithName:@"老用户" andLocationY:210.0];
        [self addContentWithName:@"新用户" andLocationY:350.0];
        [self nextButton];
    }
    return self;
}
//210  350
- (void)addContentWithName:(NSString *)name andLocationY:(CGFloat)y{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(y);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(130);
    }];
    self.lastView = v;
    UILabel *lb = [[UILabel alloc] init];
    if ([name isEqualToString:@"老用户"]) {
        lb.text = @"老用户（点击图片可放大）";
    }else{
        lb.text = @"新用户（点击图片可放大）";
    }
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
            make.top.mas_equalTo(self.lastView.mas_bottom).mas_equalTo(40);
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
    NSInteger index = 0;
    
    for (int i = 0; i<self.imageButtons.count; i++) {
        UIButton *b = self.imageButtons[i];
        if ([b isEqual:self.currentImageButton]) {
            index = i;
        }
    }
    
    UIButton *btn = self.removeButtons[index];
    btn.hidden = NO;
    UIViewController *viewController = [self viewController];
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Method

- (void)chooseImageAction:(UIButton *)button{
    self.currentImageButton = button;
    __block __weak TransferCardView *weakself = self;
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
    NSInteger index = 0;
    for (int i = 0; i<self.removeButtons.count; i++) {
        UIButton *b = self.removeButtons[i];
        if ([b isEqual:button]) {
            index = i;
        }
    }
    UIButton *btn = self.imageButtons[index];
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

- (void)buttonClickAction:(UIButton *)button{
    NSLog(@"---------下一步");
}
@end
