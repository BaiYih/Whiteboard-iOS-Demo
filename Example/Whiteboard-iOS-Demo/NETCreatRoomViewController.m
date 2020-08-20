//
//  NETCreatRoomViewController.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/20.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETCreatRoomViewController.h"
#import <Masonry/Masonry.h>

@interface NETCreatRoomViewController ()

@property (nonatomic, assign) NETCreatRoomViewType type;

@property (nonatomic, strong) UILabel *roomLabel;
@property (nonatomic, strong) UITextField *roomTextField;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UITextField *nickTextField;

@property (nonatomic, strong) UIButton *finishButton;

@end

@implementation NETCreatRoomViewController

- (instancetype)initWithType:(NETCreatRoomViewType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    [self setupData];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18.5],
    NSForegroundColorAttributeName:[UIColor colorWithRed:(33)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:1.0]}];
    self.title = self.type == NETCreatRoomViewTypeCreate ? @"创建房间" : @"加入房间";
        
    self.roomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.roomLabel.textAlignment = NSTextAlignmentLeft;
    self.roomLabel.font = [UIFont systemFontOfSize:16.0];
    self.roomLabel.textColor = [UIColor colorWithRed:(33)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:1.0];
    self.roomLabel.text = self.type == NETCreatRoomViewTypeCreate ? @"房间主题" : @"房间号";
    [self.view addSubview:self.roomLabel];
    
    self.roomTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    NSString *roomPlaceholder = self.type == NETCreatRoomViewTypeCreate ? @"请输入房间主题" : @"请输入房间号";
    NSMutableAttributedString *roomPlaceholderString = [[NSMutableAttributedString alloc] initWithString:roomPlaceholder attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:(188)/255.0 green:(189)/255.0 blue:(189)/255.0 alpha:1.0], NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    self.roomTextField.attributedPlaceholder = roomPlaceholderString;

    //FIXME:临时
    self.roomTextField.layer.borderWidth = 1.0f;
    self.roomTextField.layer.borderColor = [UIColor colorWithRed:(231)/255.0 green:(231)/255.0 blue:(231)/255.0 alpha:1.0].CGColor;
    self.roomTextField.layer.cornerRadius = 4.0f;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];//textField向内缩进用
    self.roomTextField.leftView = view;
    self.roomTextField.leftViewMode = UITextFieldViewModeAlways;
    /***********/
    [self.view addSubview:self.roomTextField];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
    self.nickNameLabel.font = [UIFont systemFontOfSize:16.0];
    self.nickNameLabel.textColor = [UIColor colorWithRed:(33)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:1.0];
    self.nickNameLabel.text = @"昵称";
    [self.view addSubview:self.nickNameLabel];
    
    self.nickTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    NSString *nicknamePlaceholder = @"请输入昵称";
    NSMutableAttributedString *nicknamePlaceholderString = [[NSMutableAttributedString alloc] initWithString:nicknamePlaceholder attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:(188)/255.0 green:(189)/255.0 blue:(189)/255.0 alpha:1.0], NSFontAttributeName : [UIFont systemFontOfSize:16]}];
    self.nickTextField.attributedPlaceholder = nicknamePlaceholderString;

    
    //FIXME:临时
    self.nickTextField.layer.borderWidth = 1.0f;
    self.nickTextField.layer.borderColor = [UIColor colorWithRed:(231)/255.0 green:(231)/255.0 blue:(231)/255.0 alpha:1.0].CGColor;
    self.nickTextField.layer.cornerRadius = 4.0f;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];//textField向内缩进用
    self.nickTextField.leftView = leftView;
    self.nickTextField.leftViewMode = UITextFieldViewModeAlways;
    /***********/
    [self.view addSubview:self.nickTextField];
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishButton setBackgroundImage:[self getImageWithColor:[UIColor colorWithRed:(16)/255.0 green:(107)/255.0 blue:(197)/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [self.finishButton setBackgroundImage:[self getImageWithColor:[UIColor colorWithRed:(227)/255.0 green:(232)/255.0 blue:(236)/255.0 alpha:1.0]] forState:UIControlStateDisabled];
    [self.finishButton setTitle:self.title forState:UIControlStateNormal];
    self.finishButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    //FIXME:临时
    self.finishButton.layer.cornerRadius = 4.0f;
    self.finishButton.clipsToBounds = YES;
    
    [self.view addSubview:self.finishButton];
    
    //FIXME:临时
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    [self.roomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(navHeight + 69);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.equalTo(@(21));
    }];
    
    [self.roomTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomLabel.mas_bottom).offset(8);
        make.left.equalTo(self.roomLabel.mas_left);
        make.right.equalTo(self.roomLabel.mas_right);
        make.height.equalTo(@(40));
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.roomTextField.mas_bottom).offset(16);
        make.left.equalTo(self.roomLabel.mas_left);
        make.right.equalTo(self.roomLabel.mas_right).offset(-30);
        make.height.equalTo(@(21));
    }];
    
    [self.nickTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(8);
        make.left.equalTo(self.roomTextField.mas_left);
        make.right.equalTo(self.roomTextField.mas_right);
        make.height.equalTo(@(40));
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY).offset(38);
        make.left.equalTo(self.roomTextField.mas_left);
        make.right.equalTo(self.roomTextField.mas_right);
        make.height.equalTo(@(40));
    }];
    
    self.finishButton.enabled = NO;
}

- (void)setupData
{
    
}

 - (void)actionFinishButton:(id)sender
 {
     if (self.type == NETCreatRoomViewTypeCreate) {
         
     } else {
         
     }
 }

//FIXME: 临时，后续加入分类中
- (UIImage*)getImageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
