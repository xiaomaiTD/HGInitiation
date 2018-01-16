//
//  UIViewController+HGAlert.m
//  HGInitiation
//
//  Created by __无邪_ on 2018/1/12.
//  Copyright © 2018年 __无邪_. All rights reserved.
//

#import "UIViewController+HGAlert.h"

@implementation UIViewController (HGAlert)


- (void)showAlertMessage:(NSString *)message withTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmHandler:(void (^)(void))confirmHandler cancelHandler:(void (^)(void))cancelHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        confirmHandler();
    }];
    [alertController addAction:confirmAction];
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancelHandler();
        }];
        [alertController addAction:cancelAction];
    }
    if (self.navigationController) {
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [[[UIApplication sharedApplication].keyWindow rootViewController] presentViewController:alertController animated:YES completion:nil];
    }
    
}
- (void)showAlertMessage:(NSString *)message completionHandler:(void (^)(void))completionHandler {
    [self showAlertMessage:message withTitle:NSLocalizedString(@"提示", @"alert-tip") confirmTitle:NSLocalizedString(@"确定",@"alert-confirm") cancelTitle:nil confirmHandler:completionHandler cancelHandler:nil];
}



@end