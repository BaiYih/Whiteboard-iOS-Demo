//
//  NETWhiteNavigationController.m
//  Whiteboard-iOS-Demo_Example
//
//  Created by BaiYih on 2020/8/21.
//  Copyright © 2020 LiMing. All rights reserved.
//

#import "NETWhiteNavigationController.h"

@interface NETWhiteNavigationController ()

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;


@end

@implementation NETWhiteNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        self.interfaceOrientation = UIInterfaceOrientationPortrait;
        self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


//设置是否允许自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

//设置支持的屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.interfaceOrientationMask ;
}

//设置presentation方式展示的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.interfaceOrientation ;
}

- (void)setupOrientationLandscape:(BOOL)landscape
{
//    if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {
//        self.interfaceOrientation = UIInterfaceOrientationLandscapeRight;
//        self.interfaceOrientationMask = UIInterfaceOrientationMaskLandscapeRight;
//        //设置屏幕的转向为横屏
//        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
//    }
//    else {
//        self.interfaceOrientation = UIInterfaceOrientationPortrait;
//        self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
//        //设置屏幕的转向为竖屏
//        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
//    }
    
    if (landscape) {
        self.interfaceOrientation = UIInterfaceOrientationLandscapeRight;
        self.interfaceOrientationMask = UIInterfaceOrientationMaskLandscapeRight;
        //设置屏幕的转向为横屏
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationLandscapeRight) forKey:@"orientation"];
    } else {
        self.interfaceOrientation = UIInterfaceOrientationPortrait;
        self.interfaceOrientationMask = UIInterfaceOrientationMaskPortrait;
        //设置屏幕的转向为竖屏
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    }
    
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
