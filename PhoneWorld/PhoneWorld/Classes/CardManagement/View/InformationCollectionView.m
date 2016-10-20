//
//  InformationCollectionView.m
//  PhoneWorld
//
//  Created by 刘岑颖 on 16/10/18.
//  Copyright © 2016年 xiyoukeji. All rights reserved.
//

#import "InformationCollectionView.h"
#import "SettlementDetailViewController.h"

@interface InformationCollectionView ()

@property (nonatomic) NSArray *leftTitles;
@property (nonatomic) NSArray *detailTitles;
@property (nonatomic) NSArray *imageTitles;
@property (nonatomic) NSMutableArray *textFields;
@property (nonatomic) UIButton *currentImageButton;
@property (nonatomic) NSMutableArray *removeButtons;
@property (nonatomic) NSMutableArray *imageButtons;
@property (nonatomic) UIView *view;

@end

@implementation InformationCollectionView

- (instancetype)initWithFrame:(CGRect)frame andUserinfos:(NSMutableDictionary *)userinfos
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BACKGROUND;
        self.leftTitles = @[@"开户人姓名",@"证件号码",@"证件地址",@"备注"];
        self.detailTitles = @[@"请输入开户人姓名",@"请输入证件号码",@"请输入证件地址",@"请输入备注信息"];
        self.imageTitles = @[@"手持身份证正面照",@"身份证背面照"];
        self.textFields = [NSMutableArray array];
        self.removeButtons = [NSMutableArray array];
        self.imageButtons = [NSMutableArray array];
        self.userinfosDic = userinfos;
        [self tableView];
        [self addContent];
        [self addTextFields];
        [self nextButton];
    }
    return self;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(159);
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (void)addTextFields{
    for (int i = 0; i < 4; i ++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 5 + 40*i, screenWidth - 115, 30)];
        [self addSubview:tf];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.hidden = YES;
        tf.tag = 100 + i;
        tf.textColor = [Utils colorRGB:@"#666666"];
        tf.font = [UIFont systemFontOfSize:12];
        tf.delegate = self;
        tf.returnKeyType = UIReturnKeyDone;
        [tf addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.textFields addObject:tf];
    }
}

- (void)addContent{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_equalTo(10);
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

#pragma mark - UITableView Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setSelectedBackgroundView:[UIView new]];
    
    cell.textLabel.text = self.leftTitles[indexPath.row];
    cell.textLabel.textColor = [Utils colorRGB:@"#666666"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = self.detailTitles[indexPath.row];
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#cccccc"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (UITextField *tf in self.textFields) {
        tf.hidden = YES;
    }
    
    UITextField *tf = self.textFields[indexPath.row];
    tf.hidden = NO;
    [tf becomeFirstResponder];
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    for (UITextField *tf in self.textFields) {
        tf.hidden = YES;
    }
    return YES;
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
- (void)textFieldChanged:(UITextField *)textField{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag - 100 inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = textField.text;
    cell.detailTextLabel.textColor = [Utils colorRGB:@"#666666"];
}

- (void)chooseImageAction:(UIButton *)button{
    self.currentImageButton = button;
    __block __weak InformationCollectionView *weakself = self;
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
    UIViewController *vc = [self viewController];
    SettlementDetailViewController *svc = [SettlementDetailViewController new];
    svc.userinfosDic = self.userinfosDic;
    [vc.navigationController pushViewController:svc animated:YES];
}

@end
