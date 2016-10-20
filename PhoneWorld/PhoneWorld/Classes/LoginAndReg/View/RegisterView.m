//
//  RegisterView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/17.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "RegisterView.h"
#import "RegisterOneTVCell.h"

@interface RegisterView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *details;
@property (nonatomic) NSArray *channelType;

@property (nonatomic) UILabel *verificationCodeLB;
//选择图片
@property (nonatomic) UIView *view;
@property (nonatomic) NSMutableArray *imageButtons;
@property (nonatomic) NSMutableArray *removeButtons;
@property (nonatomic) NSArray *imageTitles;
@property (nonatomic) UIButton *currentImageButton;

@end

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(screenWidth, 680);
        self.bounces = NO;
        self.leftTitles = @[@"＊用户名",@"＊密码",@"＊真实姓名",@"＊身份证号码",@"＊手机号码",@"＊验证码",@"邮箱",@"＊渠道类型",@"＊渠道名称",@"＊上级推荐码"];
        self.details = @[@"请输入用户名",@"请输入密码",@"请输入真实姓名",@"请输入身份证号码",@"请输入手机号",@"请输入验证码",@"请输入有效邮箱",@"请选择",@"请输入渠道名称",@"请输入上级推荐码"];
        self.channelType = @[@"总代理",@"一级代理",@"二级代理",@"渠道商"];
        
        self.removeButtons = [NSMutableArray array];
        self.imageButtons = [NSMutableArray array];
        self.imageTitles = @[@"手持身份证正面照",@"身份证背面照"];
        
        self.inputTFs = [NSMutableArray array];
        self.backgroundColor = COLOR_BACKGROUND;
        
        self.registerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, screenWidth, 440) style:UITableViewStylePlain];
        self.registerTableView.delegate = self;
        self.registerTableView.dataSource = self;
        self.registerTableView.bounces = NO;
        self.registerTableView.tableFooterView = [UIView new];
        [self.registerTableView registerClass:[RegisterOneTVCell class] forCellReuseIdentifier:@"regCell"];
        [self addSubview:self.registerTableView];
        
        [self addContent];
        [self nextButton];
    }
    return self;
}


- (void)addContent{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.registerTableView.mas_bottom).mas_equalTo(10);
        make.width.mas_equalTo(screenWidth);
        make.height.mas_equalTo(130);
    }];
    self.view = v;
    
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
            make.top.mas_equalTo(self.view.mas_bottom).mas_equalTo(40);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(171);
            make.bottom.mas_equalTo(-20);
        }];
        [_nextButton setTitle:@"确定" forState:UIControlStateNormal];
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


#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectedBackgroundView = [UIView new];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;//去左侧空白
    [cell.textLabel setTextColor:[Utils colorRGB:@"#666666"]];
    cell.textLabel.text = self.leftTitles[indexPath.row];
    NSRange range = [self.leftTitles[indexPath.row] rangeOfString:@"＊"];
    cell.textLabel.attributedText = [Utils setTextColor:cell.textLabel.text FontNumber:[UIFont systemFontOfSize:14] AndRange:range AndColor:[Utils colorRGB:@"#ec6c00"]];
    
    cell.detailTextLabel.text = self.details[indexPath.row];
    if ([self.leftTitles[indexPath.row] isEqualToString:@"＊渠道类型"]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([self.leftTitles[indexPath.row] isEqualToString:@"＊验证码"]) {
        cell.detailTextLabel.text = @"";
        UIButton *identifyingButton = [[UIButton alloc] init];
        [identifyingButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [identifyingButton setTitleColor:[Utils colorRGB:@"#666666"] forState:UIControlStateNormal];
        identifyingButton.titleLabel.font = [UIFont systemFontOfSize:12];
        identifyingButton.backgroundColor = [Utils colorRGB:@"#f9f9f9"];
        identifyingButton.layer.cornerRadius = 6;
        identifyingButton.layer.masksToBounds = YES;
        identifyingButton.tag = 1300;
        [identifyingButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:identifyingButton];
        [identifyingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(8);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(24);
            make.width.mas_equalTo(70);
        }];
        self.verificationCodeButton = identifyingButton;
        
        UILabel *lb = [[UILabel alloc] init];
        lb.text = @" 情输入验证码";
        lb.font = [UIFont systemFontOfSize:12];
        lb.textColor = [Utils colorRGB:@"#cccccc"];
        [cell.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(identifyingButton.mas_left).mas_equalTo(-20);
            make.centerY.mas_equalTo(0);
        }];
        lb.textAlignment = NSTextAlignmentRight;
        self.verificationCodeLB = lb;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    [cell.detailTextLabel setTextColor:[Utils colorRGB:@"#cccccc"]];
    
    //添加文本输入框
    UITextField *tf = [[UITextField alloc] init];
    [cell.contentView addSubview:tf];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    
    if(indexPath.row == 5){
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(110);
            make.right.mas_equalTo(self.verificationCodeButton.mas_left).mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(5);
        }];
    }else{
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(110);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(5);
        }];
    }
    [self.inputTFs addObject:tf];
    tf.tag = indexPath.row;
    tf.delegate = self;
    tf.hidden = YES;
    [tf setReturnKeyType:UIReturnKeyDone];
    [tf setFont:[UIFont systemFontOfSize:12]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 7) {
        //选择渠类型
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"渠道类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
        for (int i = 0; i < self.channelType .count; i ++) {
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.channelType[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                cell.detailTextLabel.text = self.channelType[i];
                cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
            }];
            [ac addAction:action1];
        }
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    }else{
        for (UITextField *textF in self.inputTFs) {
            textF.hidden = YES;
        }
        UITextField *tf = self.inputTFs[indexPath.row];
        tf.hidden = NO;
        [tf becomeFirstResponder];
    }
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger row = textField.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.registerTableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
    [textField resignFirstResponder];
    textField.hidden = YES;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        
    }else{
        if (textField.tag == 5) {
            self.verificationCodeLB.text = textField.text;
            self.verificationCodeLB.textColor = [Utils colorRGB:@"#666666"];
        }else{
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
            UITableViewCell *cell = [self.registerTableView cellForRowAtIndexPath:indexPath];
            cell.detailTextLabel.text = textField.text;
            cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
        }
    }
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
    __block __weak RegisterView *weakself = self;
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


- (void)buttonClickAction:(UIButton *)button{
    if ([button.currentTitle isEqualToString:@"确定"]) {
        NSLog(@"---------确定注册------");
    }else{
        NSLog(@"---------获取验证码------");
    }
}

@end
