//
//  AppDelegate.m
//  AppTestObj
//
//  Created by SANGWON HAN on 16/03/2020.
//  Copyright © 2020 SANGWON HAN. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

//2020.10.26 hansw 백그라운드 테스크 시간을 늘려주는 로직
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //Start background task
        //__block UIBackgroundTaskIdentifier bgTask;//이건 나중에 전역 변수로 선언해놔야함~ 동작하는 부분이 다른곳에 있을경우

        self.bgTask = [application beginBackgroundTaskWithExpirationHandler:^{

            // 이 곳에 백그라운드 작업이 종료되기 직전에 호출되는 Block 이다.
            // 이 곳까지 진입했다는 것은 곧 종료됨을 의미한다. 이를 가정해야한다.
            // 10분뒤에도 종료가 되지 않는다면!!
            [application endBackgroundTask:self.bgTask];
            self.bgTask = UIBackgroundTaskInvalid;

        }];
        //최대 10분 보장
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(bgMonitor) userInfo:nil repeats:YES];

    
}

-(void)bgMonitor{

    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground){
        NSTimeInterval timeLeft = [UIApplication sharedApplication].backgroundTimeRemaining;//유지 시간 얻기.
        //NSLog(@"Background time remaining: %.0f seconds (~%d mins)", timeLeft, (int)timeLeft / 60);
        if((int)timeLeft / 60==0){
            //작업이 완료되는경우 아래와같은 종료
            self.bgTask = UIBackgroundTaskInvalid;
        }

    }

}

@end
