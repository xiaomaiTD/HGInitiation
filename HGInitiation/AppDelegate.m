//
//  AppDelegate.m
//  HGInitiation
//
//  Created by __无邪_ on 2017/12/25.
//  Copyright © 2017年 __无邪_. All rights reserved.
//  http://www.wtfpl.net/txt/copying/

#import "AppDelegate.h"
#import "HGThemeManager.h"
#import "HGThemeDefault.h"
#import "SystemConfiguration/SCNetworkReachability.h"
#import "HGHelperReachability.h"
#import <YYReachability.h>
#import "HGDownloader.h"

#ifndef __OPTIMIZE__
#import "HGHelperFPS.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self installWindow];
    [self installFuns];
    [self installCustomConfiguration];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


//This method lets your application know that it is about to be terminated and purged from memory entirely. You should use this method to perform any final clean-up tasks for your application, such as freeing shared resources, saving user data, and invalidating timers. Your implementation of this method has approximately five seconds to perform any tasks and return. If the method does not return before time expires, the system may kill the process altogether.
//
//For applications that do not support background execution or are linked against iOS 3.x or earlier, this method is always called when the user quits the application. For applications that support background execution, this method is generally not called when the user quits the application because the application simply moves to the background in that case. However, this method may be called in situations where the application is running in the background (not suspended) and the system needs to terminate it for some reason.
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


#pragma mark -
// Applications using an NSURLSession with a background configuration may be launched or resumed in the background in order to handle the
// completion of tasks in that session, or to handle authentication. This method will be called with the identifier of the session needing
// attention. Once a session has been created from a configuration object with that identifier, the session's delegate will begin receiving
// callbacks. If such a session has already been created (if the app is being resumed, for instance), then the delegate will start receiving
// callbacks without any action by the application. You should call the completionHandler as soon as you're finished handling the callbacks.
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    NSLog(@"--------------%@ %s",identifier,__func__);
    if ([identifier isEqualToString:HGDownloaderDefaultIdentifier]) {
        [[HGDownloader defaultInstance] setDidFinishEventsForBackgroundURLSessionBlock:^(NSURLSession *session) {
            completionHandler();
        }];
    }
}


#pragma mark - install


- (void)installWindow {
    self.tabBarController = [[HGBASETabBarController alloc] init];
    [self.tabBarController setDefaultViewControllers];
    
    self.window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

- (void)installFuns {
    [[HGHelperReachability sharedInstance] startMonitoring];
    // 应用皮肤
    NSString *themeClassName = [[NSUserDefaults standardUserDefaults] objectForKey:HGSelectedThemeClassName];
    [HGThemeManager sharedInstance].currentTheme = [[NSClassFromString(themeClassName) alloc] init];
    
#ifndef __OPTIMIZE__
    [[HGHelperFPS sharedInstance] setHidden:NO];
#endif
}
- (void)installCustomConfiguration {
    if (@available(iOS 11.0, *)){
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}



@end
