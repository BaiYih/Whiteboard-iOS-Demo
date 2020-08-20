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

@interface NETStartViewController ()
{
    UIImageView *navBarHairlineImageView;
}

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) UILabel *joinLabel;
@property (nonatomic, strong) UILabel *createLabel;
@property (nonatomic, strong) UILabel *serviceLabel;

@end

@implementation NETStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupData];
}

- (void)setupView
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bac"] forBarMetrics:UIBarMetricsDefault];
    }
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
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

    self.serviceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.serviceLabel.textAlignment = NSTextAlignmentCenter;
    self.serviceLabel.numberOfLines = 2;
    self.serviceLabel.font = [UIFont systemFontOfSize:12];
    self.serviceLabel.text = @"使用产品即代表阅读并同意《软件许可及服务协议》\n和《隐私政策》";
    [self.view addSubview:self.serviceLabel];
    
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
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-32);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@(36));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = [UIColor colorWithRed:(231)/255.0 green:(231)/255.0 blue:(231)/255.0 alpha:1.0];
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@(0.5));
        make.top.equalTo(self.joinButton.mas_top);
        make.bottom.equalTo(self.joinLabel.mas_bottom);
    }];
}

- (void)setupData
{
    self.versionLabel.text = @"1.0.0";
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }

    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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



@end
