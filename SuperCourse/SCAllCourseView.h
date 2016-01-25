//
//  SCAllCourseView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCAllCourseViewDelegate <NSObject>

-(void)startBtnDidClick;

@end

@interface SCAllCourseView : UIView

@property (nonatomic ,weak) id<SCAllCourseViewDelegate> delegate;

@end
