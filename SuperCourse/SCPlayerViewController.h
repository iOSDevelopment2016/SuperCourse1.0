//
//  SCPlayerViewController.h
//  SuperCourse
//
//  Created by Develop on 16/1/24.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCBaseViewController.h"
@class SCVIdeoInfo;

@protocol SCPlayerViewControllerDelegate <NSObject>

-(void)changeViewLooking;

@end

@protocol SCPlayerVCDelegate <NSObject>

-(NSTimeInterval *)pointTime;

@end


@interface SCPlayerViewController : SCBaseViewController

@property (nonatomic ,strong) SCVIdeoInfo *currentVideoInfo;
@property (nonatomic, strong) id<SCPlayerViewControllerDelegate> delegate;
@property (nonatomic, strong) id<SCPlayerVCDelegate> timeDelegate;

@end
