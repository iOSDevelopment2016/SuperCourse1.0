//
//  SCCoursePlayLog.h
//  SuperCourse
//
//  Created by 刘芮东 on 16/2/2.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCoursePlayLog : NSObject


@property (nonatomic, strong) NSString *studyles_id; // 课程内码
@property (nonatomic, assign) float oversty_time; // 上次停止的时间
@property (nonatomic, assign) NSString *is_ready; // 上次是否播放完毕

@end
