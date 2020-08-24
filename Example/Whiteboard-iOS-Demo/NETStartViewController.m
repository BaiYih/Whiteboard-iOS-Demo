//
//  NETStartViewController.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/20.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETStartViewController.h"
#import <Masonry/Masonry.h>
#import "NETCreatRoomViewController.h"
#import "NETWhiteNavigationController.h"

@interface NETStartViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UILabel *joinLabel;
@property (nonatomic, strong) UILabel *createLabel;
@property (nonatomic, strong) UITextView *serviceTextView;

@end

@implementation NETStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupData];
}

- (void)setupView
{    
    self.logoView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.logoView.image = [UIImage imageNamed:@"start_lofo"];
    [self.view addSubview:self.logoView];
    
    self.versionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.versionLabel.font = [UIFont systemFontOfSize:12.0];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.textColor = [UIColor colorWithRed:(33)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:0.6];
    [self.view addSubview:self.versionLabel];
    
    self.joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.joinButton addTarget:self action:@selector(actionJoinButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.joinButton setImage:[UIImage imageNamed:@"join_room"] forState:UIControlStateNormal];
    [self.view addSubview:self.joinButton];
    
    self.createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.createButton addTarget:self action:@selector(actionCreateButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.createButton setImage:[UIImage imageNamed:@"create_room"] forState:UIControlStateNormal];
    [self.view addSubview:self.createButton];
    
    self.joinLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.joinLabel.font = [UIFont systemFontOfSize:16.0];
    self.joinLabel.textAlignment = NSTextAlignmentCenter;
    self.joinLabel.textColor = [UIColor colorWithRed:(33)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:1.0];
    self.joinLabel.text = @"加入房间";
    [self.view addSubview:self.joinLabel];
    
    self.createLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.createLabel.font = [UIFont systemFontOfSize:16.0];
    self.createLabel.textAlignment = NSTextAlignmentCenter;
    self.createLabel.textColor = [UIColor colorWithRed:(33)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:1.0];
    self.createLabel.text = @"创建房间";
    [self.view addSubview:self.createLabel];

    self.serviceTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.serviceTextView.textAlignment = NSTextAlignmentCenter;
    self.serviceTextView.font = [UIFont systemFontOfSize:12];
    self.serviceTextView.textContainerInset = UIEdgeInsetsZero;
    NSString *serviceStr = @"使用产品即代表阅读并同意《软件许可及服务协议》\n和《隐私政策》";
    self.serviceTextView.attributedText = [self getContentLabelAttributedText:serviceStr];
    self.serviceTextView.delegate = self;

    [self.view addSubview:self.serviceTextView];
    
    CGFloat width = self.view.frame.size.width / 4;
    [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX).offset(-width);
        make.width.and.height.equalTo(@80);
    }];
    
    [self.createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY).offset(-20);
        make.centerX.equalTo(self.view.mas_centerX).offset(width);
        make.width.and.height.equalTo(@80);
    }];
    
    [self.joinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.joinButton.mas_bottom).offset(16);
        make.centerX.equalTo(self.joinButton.mas_centerX);
        make.width.equalTo(@(100));
        make.height.equalTo(@(24));
    }];
    
    [self.createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.createButton.mas_bottom).offset(16);
        make.centerX.equalTo(self.createButton.mas_centerX);
        make.width.equalTo(@(100));
        make.height.equalTo(@(24));
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.joinButton.mas_top).offset(-97);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@(18));
        make.width.equalTo(self.view.mas_width);
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.versionLabel.mas_top).offset(-13);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(96));
        make.height.equalTo(@(20));
    }];
    
    [self.serviceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-32);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(36));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor colorWithRed:(244)/255.0 green:(244)/255.0 blue:(244)/255.0 alpha:1.0];
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(1));
        make.top.equalTo(self.joinButton.mas_top);
        make.bottom.equalTo(self.joinLabel.mas_bottom);
    }];
}

- (void)setupData
{
    self.versionLabel.text = @"1.0.0";
}

- (NSAttributedString *)getContentLabelAttributedText:(NSString *)text
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor colorWithRed:(35)/255.0 green:(35)/255.0 blue:(36)/255.0 alpha:0.6]}];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(37)/255.0 green:(121)/255.0 blue:(96)/255.0 alpha:1.0] range:NSMakeRange(12, 11)];
     [attrStr addAttribute:NSLinkAttributeName value:@"service://" range:NSMakeRange(12, 11)];

     [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:(37)/255.0 green:(121)/255.0 blue:(96)/255.0 alpha:1.0] range:NSMakeRange(text.length - 6, 6)];
     [attrStr addAttribute:NSLinkAttributeName value:@"privacy://" range:NSMakeRange(text.length - 6, 6)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.paragraphSpacing = 3;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    
    return attrStr;

}

#pragma mark - click
- (void)actionJoinButton:(id)sender
{
    NSLog(@"action join button");
    NETCreatRoomViewController *joinVC = [[NETCreatRoomViewController alloc] initWithType:NETCreatRoomViewTypeJoin];
    [self.navigationController pushViewController:joinVC animated:YES];
}

- (void)actionCreateButton:(id)sender
{
    NSLog(@"action create button");
    NETCreatRoomViewController *joinVC = [[NETCreatRoomViewController alloc] initWithType:NETCreatRoomViewTypeCreate];
    [self.navigationController pushViewController:joinVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([[URL scheme] isEqualToString:@"service"]) {
        NSLog(@"~~~~~ service 跳转");
        return NO;
    }else if ([[URL scheme] isEqualToString:@"privacy"]) {
        NSLog(@"~~~~~ privacy 跳转");

        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}


@end
