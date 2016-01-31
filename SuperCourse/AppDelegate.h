//
//  AppDelegate.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *userSession;


-(void)solidateUserSession:(NSString *)userSession;


@end

